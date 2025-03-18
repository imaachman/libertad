import 'dart:io';
import 'dart:math';

import 'package:isar/isar.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/mock/mock_authors.dart';
import 'package:libertad/data/mock/mock_books.dart';
import 'package:libertad/data/mock/mock_borrowers.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/data/models/image_folder.dart';
import 'package:libertad/data/models/issue_status.dart';
import 'package:libertad/data/models/issued_copy_sort.dart';
import 'package:libertad/data/models/search_result.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../models/author.dart';
import '../models/book.dart';

/// Repository of methods which we can use to interact with the database.
class DatabaseRepository {
  /// Private constructor to create a singleton.
  DatabaseRepository._internal();

  /// We use this instance to utilize database repository.
  static final DatabaseRepository instance = DatabaseRepository._internal();

  /// Isar instance used for database operations.
  late final Isar _isar;

  /// Initialize database.
  /// This method needs to be called before we can interact with the database.
  /// Typically called in the [main] method before running the app.
  Future<void> initialize() async {
    // Get application documents directory.
    final Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    // Create sub-directory to be used for app's database and file storage.
    final Directory appDirectory =
        await Directory('${applicationDocumentsDirectory.path}/Libertad')
            .create();
    // Load Isar instance with the relevant collections.
    _isar = await Isar.open(
      [BookSchema, AuthorSchema, BookCopySchema, BorrowerSchema],
      directory: appDirectory.path,
    );
  }

  /// A stream of books data. Allows us to watch for changes in the books
  /// collection and update UI.
  Stream<void> get booksStream => _isar.books.watchLazy(fireImmediately: true);

  /// A stream of book data. Allows us to watch for changes to a particular book
  /// from the collection and update UI.
  Stream<void> bookStream(Id id) =>
      _isar.books.watchObject(id, fireImmediately: true);

  /// A stream of authors data. Allows us to watch for changes in the authors
  /// collection and update UI.
  Stream<void> get authorsStream =>
      _isar.authors.watchLazy(fireImmediately: true);

  /// A stream of author data. Allows us to watch for changes to a particular
  /// author from the collection and update UI.
  Stream<void> authorStream(Id id) =>
      _isar.authors.watchObject(id, fireImmediately: true);

  /// A stream of book copies data. Allows us to watch for changes in the book
  /// copies collection and update UI.
  Stream<void> get bookCopiesStream =>
      _isar.bookCopys.watchLazy(fireImmediately: true);

  /// A stream of book copy data. Allows us to watch for changes to a particular
  /// book copy from the collection and update UI.
  Stream<void> bookCopyStream(Id id) =>
      _isar.bookCopys.watchObject(id, fireImmediately: true);

  /// A stream of borrowers data. Allows us to watch for changes in the
  /// borrowers collection and update UI.
  Stream<void> get borrowersStream =>
      _isar.borrowers.watchLazy(fireImmediately: true);

  /// A stream of borrower data. Allows us to watch for changes to a particular
  /// borrower from the collection and update UI.
  Stream<void> borrowerStream(Id id) =>
      _isar.borrowers.watchObject(id, fireImmediately: true);

  /// Clear entire database. (for development purposes only)
  Future<void> clearDatabase() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }

  /// Reset database to its original state with mock data. (for development
  /// purposes only)
  Future<void> resetDatabase() async {
    await _isar.writeTxn(() async {
      // Clear database.
      await _isar.clear();
      // Delete all the images stored in the app's image directories.
      await FilesRepository.instance.deleteImageFolder(ImageFolder.bookCovers);
      await FilesRepository.instance
          .deleteImageFolder(ImageFolder.authorProfilePictures);
      await FilesRepository.instance
          .deleteImageFolder(ImageFolder.borrowerProfilePictures);
      // Populate books and authors data.
      for (int index = 0; index < mockBooks.length; index++) {
        // Need to create a new copy of the [Book] and [Author] object every
        // time because otherwise we'll reassigning already initialized links
        // to different objects. And it is illegal to move a link to another
        // object.
        final Book book = mockBooks[index].copyWith();
        final Author author = mockAuthors[index].copyWith();
        book.author.value = author;

        // Create random number of [BookCopy] objects up to 15.
        // Each copy will have a link to the book.
        final List<BookCopy> copies =
            _generateCopies(book, Random().nextInt(15) + 1);
        // Add the copies to the database.
        await _isar.bookCopys.putAll(copies);
        // Link the copies set to the book.
        book.totalCopies.addAll(copies);

        // Update creation and updation time right before adding the book and
        // author to the database.
        book
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();
        author
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();

        // Add the book and author to the database.
        await _isar.books.put(book);
        await _isar.authors.put(author);

        // Save the book, book copies, and author links.
        // Always the last step, required to update the links in the database.
        await book.author.save();
        await book.totalCopies.save();
        await author.books.save();
      }
      // Populate borrowers data.
      for (int index = 0; index < mockBorrowers.length; index++) {
        final Borrower borrower = mockBorrowers[index].copyWith();
        // Update creation and updation time right before adding the borrowers
        // to the database.
        borrower
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();
        // Add the borrower to the database.
        await _isar.borrowers.put(borrower);
      }
    });
  }

  /// Returns all the books from the collection, sorted by [sortBy],
  /// arranged according to [sortOrder], and filtered by combining the various
  /// filter parameters.
  Future<List<Book>> getBooks({
    BookSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    Genre? genreFilter,
    Author? authorFilter,
    DateTime? oldestReleaseDateFilter,
    DateTime? newestReleaseDateFilter,
    IssueStatus? issueStatusFilter,
    int? minCopiesFilter,
    int? maxCopiesFilter,
  }) async {
    // Apply the relevant filters using the [optional] query method.
    final QueryBuilder<Book, Book, QAfterFilterCondition> queryBuilder = _isar
        .books
        .filter()
        .optional(
            genreFilter != null, (book) => book.genreEqualTo(genreFilter!))
        .optional(
            authorFilter != null,
            (book) =>
                book.author((author) => author.idEqualTo(authorFilter!.id)))
        .optional(oldestReleaseDateFilter != null,
            (book) => book.releaseDateGreaterThan(oldestReleaseDateFilter!))
        .optional(newestReleaseDateFilter != null,
            (book) => book.releaseDateLessThan(newestReleaseDateFilter!))
        .optional(issueStatusFilter != null, (book) {
          if (issueStatusFilter!.isAvailable) {
            return book.totalCopies(
                (copy) => copy.statusEqualTo(IssueStatus.available));
          } else {
            return book.not().totalCopies(
                (copy) => copy.statusEqualTo(IssueStatus.available));
          }
        })
        .optional(minCopiesFilter != null,
            (book) => book.totalCopiesLengthGreaterThan(minCopiesFilter!))
        .optional(maxCopiesFilter != null,
            (book) => book.totalCopiesLengthLessThan(maxCopiesFilter!));

    switch (sortBy) {
      // Sort the books by title.
      case BookSort.title:
        if (sortOrder == SortOrder.ascending) {
          return queryBuilder.sortByTitle().findAll();
        } else {
          return queryBuilder.sortByTitleDesc().findAll();
        }
      // Sort the books by release date.
      case BookSort.releaseDate:
        if (sortOrder == SortOrder.ascending) {
          return queryBuilder.sortByReleaseDate().findAll();
        } else {
          return queryBuilder.sortByReleaseDateDesc().findAll();
        }
      // Sort the books by number of total copies.
      case BookSort.totalCopies:
        final List<Book> books = await queryBuilder.findAll();
        books.sort((a, b) {
          if (sortOrder == SortOrder.ascending) {
            return a.totalCopies.length.compareTo(b.totalCopies.length);
          } else {
            return b.totalCopies.length.compareTo(a.totalCopies.length);
          }
        });
        return books;
      // Sort the books by number of issued copies.
      case BookSort.issuedCopies:
        final List<Book> books = await queryBuilder.findAll();
        books.sort((a, b) {
          if (sortOrder == SortOrder.ascending) {
            return a.issuedCopies.length.compareTo(b.issuedCopies.length);
          } else {
            return b.issuedCopies.length.compareTo(a.issuedCopies.length);
          }
        });
        return books;
      // Sort the books by title.
      case BookSort.dateAdded:
        if (sortOrder == SortOrder.ascending) {
          return queryBuilder.sortByCreatedAt().findAll();
        } else {
          return queryBuilder.sortByCreatedAtDesc().findAll();
        }
      // Sort the books by title.
      case BookSort.dateModified:
        if (sortOrder == SortOrder.ascending) {
          return queryBuilder.sortByUpdatedAt().findAll();
        } else {
          return queryBuilder.sortByUpdatedAtDesc().findAll();
        }
      // Return unsorted books.
      default:
        return queryBuilder.findAll();
    }
  }

  /// Returns all the authors from the collection, sorted by [sortBy] and
  /// arranged according to [sortOrder].
  Future<List<Author>> getAuthors({
    AuthorSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
  }) async {
    switch (sortBy) {
      case AuthorSort.name:
        if (sortOrder == SortOrder.ascending) {
          return _isar.authors.where().sortByName().findAll();
        } else {
          return _isar.authors.where().sortByNameDesc().findAll();
        }
      case AuthorSort.dateAdded:
        if (sortOrder == SortOrder.ascending) {
          return await _isar.authors.where().sortByCreatedAt().findAll();
        } else {
          return await _isar.authors.where().sortByCreatedAtDesc().findAll();
        }
      case AuthorSort.dateModified:
        if (sortOrder == SortOrder.ascending) {
          return await _isar.authors.where().sortByUpdatedAt().findAll();
        } else {
          return await _isar.authors.where().sortByUpdatedAtDesc().findAll();
        }
      default:
        return _isar.authors.where().findAll();
    }
  }

  /// Returns all the issued copies from the [bookCopys] collection, sorted by
  /// [sortBy], arranged according to [sortOrder], and filtered by combining the
  /// various filter parameters.
  Future<List<BookCopy>> getIssuedCopies({
    IssuedCopySort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    Book? bookFilter,
    Borrower? borrowerFilter,
    bool? overdueFilter,
    DateTime? oldestIssueDateFilter,
    DateTime? newestIssueDateFilter,
    DateTime? oldestReturnDateFilter,
    DateTime? newestReturnDateFilter,
  }) async {
    // Apply the relevant filters using the [optional] query method.
    final QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition> queryBuilder =
        _isar.bookCopys
            .filter()
            .statusEqualTo(IssueStatus.issued)
            .optional(bookFilter != null,
                (copy) => copy.book((book) => book.idEqualTo(bookFilter!.id)))
            .optional(borrowerFilter != null, (copy) {
              return copy.currentBorrower((borrower) {
                return borrower.idEqualTo(borrowerFilter!.id);
              });
            })
            .optional(overdueFilter != null, (copy) {
              if (overdueFilter!) {
                return copy.returnDateLessThan(DateTime.now());
              } else {
                return copy.returnDateGreaterThan(DateTime.now());
              }
            })
            .optional(oldestIssueDateFilter != null,
                (book) => book.issueDateGreaterThan(oldestIssueDateFilter!))
            .optional(newestIssueDateFilter != null,
                (book) => book.issueDateLessThan(newestIssueDateFilter!))
            .optional(oldestReturnDateFilter != null,
                (book) => book.returnDateGreaterThan(oldestReturnDateFilter!))
            .optional(newestReturnDateFilter != null,
                (book) => book.returnDateLessThan(newestReturnDateFilter!));

    switch (sortBy) {
      case IssuedCopySort.issueDate:
        if (sortOrder == SortOrder.ascending) {
          return queryBuilder.sortByIssueDate().findAll();
        } else {
          return queryBuilder.sortByIssueDateDesc().findAll();
        }

      case IssuedCopySort.returnDate:
        if (sortOrder == SortOrder.ascending) {
          return queryBuilder.sortByReturnDate().findAll();
        } else {
          return queryBuilder.sortByReturnDateDesc().findAll();
        }

      default:
        return queryBuilder.findAll();
    }
  }

  /// Returns all the borrowers from the collection, sorted by [sortBy],
  /// arranged according to [sortOrder], and filtered by combining the various
  /// filter parameters.
  Future<List<Borrower>> getBorrowers({
    BorrowerSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    bool? activeFilter,
    bool? defaulterFilter,
    DateTime? oldestMembershipStartDateFilter,
    DateTime? newestMembershipStartDateFilter,
  }) async {
    // Apply the relevant filters using the [optional] query method.
    final QueryBuilder<Borrower, Borrower, QAfterFilterCondition> queryBuilder =
        _isar.borrowers.filter().optional(activeFilter != null, (borrower) {
      if (activeFilter!) {
        return borrower.membershipEndDateGreaterThan(DateTime.now());
      } else {
        return borrower.membershipEndDateLessThan(DateTime.now());
      }
    }).optional(defaulterFilter != null, (borrower) {
      if (defaulterFilter!) {
        return borrower.isDefaulterEqualTo(true);
      } else {
        return borrower.isDefaulterEqualTo(false);
      }
    }).optional(oldestMembershipStartDateFilter != null, (book) {
      return book
          .membershipStartDateGreaterThan(oldestMembershipStartDateFilter!);
    }).optional(newestMembershipStartDateFilter != null, (book) {
      return book.membershipStartDateLessThan(newestMembershipStartDateFilter!);
    });

    switch (sortBy) {
      case BorrowerSort.name:
        if (sortOrder == SortOrder.ascending) {
          return await queryBuilder.sortByName().findAll();
        } else {
          return await queryBuilder.sortByNameDesc().findAll();
        }
      case BorrowerSort.membershipStartDate:
        if (sortOrder == SortOrder.ascending) {
          return await queryBuilder.sortByMembershipStartDate().findAll();
        } else {
          return await queryBuilder.sortByMembershipStartDateDesc().findAll();
        }
      case BorrowerSort.dateAdded:
        if (sortOrder == SortOrder.ascending) {
          return await queryBuilder.sortByCreatedAt().findAll();
        } else {
          return await queryBuilder.sortByCreatedAtDesc().findAll();
        }
      case BorrowerSort.dateModified:
        if (sortOrder == SortOrder.ascending) {
          return await queryBuilder.sortByUpdatedAt().findAll();
        } else {
          return await queryBuilder.sortByUpdatedAtDesc().findAll();
        }
      default:
        return queryBuilder.findAll();
    }
  }

  /// Adds a new book to the collection.
  ///
  /// [author] and [totalCopies] are required because they are [IsarLinks] and
  /// we need to create them before adding them to the [Book] object.
  ///
  /// If the author is not present in the database, it will be added.
  /// And [totalCopies] number of [BookCopy] objects will be created, added to
  /// the [Book] object, and saved to the database.
  Future<void> addBook(
    Book book,
    Author author,
    int totalCopies,
  ) async {
    await _isar.writeTxn(() async {
      // Check if the author is already present in the database.
      final Author? existingAuthor =
          await _isar.authors.where().idEqualTo(author.id).findFirst();
      final bool authorNotPresent = existingAuthor == null;
      // If the author is not present, add it to the database.
      if (authorNotPresent) {
        // Update creation and updation time right before adding the author to
        // the database.
        author
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now();
        await _isar.authors.put(author);
      }
      // Link the author to the book.
      book.author.value = author;

      // Create [totalCopies] number of [BookCopy] objects.
      // Each copy will have a link to the book.
      final List<BookCopy> copies = _generateCopies(book, totalCopies);
      // Add the copies to the database.
      await _isar.bookCopys.putAll(copies);
      // Link the copies set to the book.
      book.totalCopies.addAll(copies);

      // Update creation and updation time right before adding the book to the
      // database.
      book
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

      // Add the book to the database.
      await _isar.books.put(book);

      // Save the author and copies links.
      // Always the last step, required to update the links in the database.
      await book.author.save();
      await book.totalCopies.save();
    });
  }

  /// Updates an existing book in the collection.
  ///
  /// In case the author is changed:
  /// 1. If the old author has only one book in the library, delete the author.
  /// 2. If the new author is not present in the database, add it.
  ///
  /// In case the total copies are changed:
  /// 1. If the new total copies are more than the old total copies, create the
  ///   new copies and add them to the database.
  /// 2. If the new total copies are less than the old total copies, delete the
  ///   all the copies and replace them with the new copies. We don't want to
  ///   update the existing copies because they might have been borrowed.
  ///   TODO: Un-issue the borrowed copies before deletion.
  Future<void> updateBook(
      Book book, Author newAuthor, int newTotalCopies) async {
    // Get the old author.
    final Author oldAuthor = book.author.value!;
    // If author updated.
    final bool authorUpdated = oldAuthor != newAuthor;
    // This is old author's only book in the library.
    final bool oldAuthorsOnlyBook = oldAuthor.books.length == 1;

    // If number of total copies has been changed.
    final bool totalCopiesChanged = book.totalCopies.length != newTotalCopies;

    await _isar.writeTxn(() async {
      // If author updated.
      if (authorUpdated) {
        // Delete the old author if this is their only book in the library.
        if (oldAuthorsOnlyBook) await _isar.authors.delete(oldAuthor.id);

        // Check if the new author is already present in the database.
        final Author? existingAuthor =
            await _isar.authors.where().idEqualTo(newAuthor.id).findFirst();
        final bool newAuthorNotPresent = existingAuthor == null;
        // If the new author is not present, add it to the database.
        if (newAuthorNotPresent) await _isar.authors.put(newAuthor);

        // Link the new author to the book.
        book.author.value = newAuthor;
      }

      // If the new number of total copies is more than the old, create and add
      // the new copies to the database.
      if (newTotalCopies > book.totalCopies.length) {
        // Create the new number of [BookCopy] objects.
        // Each copy will have a link to the book.
        final List<BookCopy> newCopies = _generateCopies(
          book,
          newTotalCopies - book.totalCopies.length,
        );
        // Add the copies to the database.
        await _isar.bookCopys.putAll(newCopies);
        // Link the copies set to the book.
        book.totalCopies.addAll(newCopies);
      }
      // If the new number of total copies is less than the old, delete all the
      // copies and replace them with the new copies.
      else if (newTotalCopies < book.totalCopies.length) {
        // Delete old copies.
        await _isar.bookCopys.deleteAll(
          book.totalCopies.map((copy) => copy.id).toList(),
        );
        // Generate new copies.
        final List<BookCopy> copies = _generateCopies(
          book,
          newTotalCopies,
        );
        // Add the copies to the database.
        await _isar.bookCopys.putAll(copies);
        // Remove old copies from the book.
        book.totalCopies.removeWhere((copy) => true);
        // Link the new copies set to the book.
        book.totalCopies.addAll(copies);
      }

      // Update book update time right before it's inserted in the database.
      book.updatedAt = DateTime.now();

      // Update the book in the database.
      await _isar.books.put(book);

      // Save the author and copies links. Always the last step, required to
      // update the links in the database.
      if (authorUpdated) await book.author.save();
      if (totalCopiesChanged) await book.totalCopies.save();
    });
  }

  Future<bool> deleteBook(Book book) async {
    // Get book's author.
    final Author author = book.author.value!;
    // This is author's only book in the library.
    final bool authorsOnlyBook = author.books.length == 1;

    return await _isar.writeTxn<bool>(() async {
      // Delete author is this is their only book in the library.
      if (authorsOnlyBook) await _isar.authors.delete(author.id);

      // Un-issue issued copies since all copies are about to get deleted.
      // We do that by resetting the current and previous borrowers links.
      for (final BookCopy copy in book.issuedCopies) {
        await copy.currentBorrower.reset();
        await copy.previousBorrowers.reset();
      }

      // Delete all copies before deleting the book.
      await _isar.bookCopys
          .deleteAll(book.totalCopies.map((copy) => copy.id).toList());

      // Delete the book from the database.
      return await _isar.books.delete(book.id);
    });
  }

  Future<void> updateAuthor(Author author) async {
    await _isar.writeTxn(() async {
      // Update author update time right before it's inserted in the database.
      author.updatedAt = DateTime.now();
      _isar.authors.put(author);
    });
  }

  /// Deletes the author and their books (along with all the copies of book).
  Future<bool> deleteAuthor(Author author) async {
    return await _isar.writeTxn<bool>(() async {
      // Load books link from the database.
      await author.books.load();
      // Delete all books written by the author.
      for (final Book book in author.books) {
        // Load copies link from the database.
        await book.totalCopies.load();
        // Delete all the copies of the books first.
        for (final BookCopy copy in book.totalCopies) {
          await _isar.bookCopys.delete(copy.id);
        }
        // Delete book object.
        await _isar.books.delete(book.id);
      }
      // Finally, delete the author.
      return await _isar.authors.delete(author.id);
    });
  }

  Future<List<Author>> searchAuthors(String name) async {
    return _isar.authors
        .filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }

  /// Adds a new borrower to the collection.
  Future<void> addBorrower(Borrower borrower) async {
    await _isar.writeTxn(() async {
      // Update creation and updation time right before adding the borrower to
      // the database.
      borrower
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();
      // Add the borrower to the database.
      await _isar.borrowers.put(borrower);
    });
  }

  /// Updates an existing borrower in the collection.
  Future<void> updateBorrower(Borrower borrower) async {
    await _isar.writeTxn(() async {
      // Update borrower update time right before it's inserted in the database.
      borrower.updatedAt = DateTime.now();
      // Update the borrower in the database.
      await _isar.borrowers.put(borrower);
    });
  }

  /// Deletes the borrower.
  Future<bool> deleteBorrower(Borrower borrower) async {
    return await _isar.writeTxn<bool>(() async {
      // Change the issue status for all the books issued by the borrower.
      for (final BookCopy copy in borrower.currentlyIssuedBooks) {
        copy.status = IssueStatus.available;
        await _isar.bookCopys.put(copy);
      }
      // Un-issue all the books issued to the borrower.
      // We reset the links to do so.
      await borrower.currentlyIssuedBooks.reset();
      await borrower.previouslyIssuedBooks.reset();
      return await _isar.borrowers.delete(borrower.id);
    });
  }

  Future<List<Borrower>> searchBorrowers(String name,
      {bool active = false}) async {
    final QueryBuilder<Borrower, Borrower, QAfterFilterCondition> queryBuilder =
        _isar.borrowers.filter().nameContains(name, caseSensitive: false);
    if (active == true) {
      return queryBuilder
          .membershipEndDateGreaterThan(DateTime.now())
          .findAll();
    } else {
      return queryBuilder.findAll();
    }
  }

  Future<void> issueCopy(BookCopy copy, Borrower borrower) async {
    return _isar.writeTxn(() async {
      copy.currentBorrower.value = borrower;
      await _isar.bookCopys.put(copy);
      copy.currentBorrower.save();
    });
  }

  Future<void> returnCopy(BookCopy copy, Borrower borrower) async {
    return _isar.writeTxn(() async {
      // Return copy by resetting the borrower link.
      copy.currentBorrower.reset();
      // If returned copy was overdue, we update borrower with defaulter status
      // and fine.
      await _isar.borrowers.put(borrower);
      copy.previousBorrowers.add(borrower);
      await _isar.bookCopys.put(copy);
      copy.currentBorrower.save();
      copy.previousBorrowers.save();
    });
  }

  Future<void> acceptFine(Borrower borrower) async {
    return _isar.writeTxn(() async {
      await _isar.borrowers.put(borrower);
    });
  }

  List<BookCopy> _generateCopies(Book book, int totalCopies) {
    return List.generate(
      totalCopies,
      (index) => BookCopy()..book.value = book,
    );
  }

  Future<SearchResult> searchDatabase(String query) async {
    final List<Book> books = await _isar.books
        .filter()
        .titleContains(query, caseSensitive: false)
        .or()
        .author((q) => q.nameContains(query, caseSensitive: false))
        .findAll();
    final List<Author> authors = await _isar.authors
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .books((q) => q.titleContains(query, caseSensitive: false))
        .findAll();
    final List<BookCopy> issuedCopies = await _isar.bookCopys
        .filter()
        .statusEqualTo(IssueStatus.issued)
        .and()
        .book((q) => q.titleContains(query, caseSensitive: false))
        .findAll();
    final List<Borrower> borrowers = await _isar.borrowers
        .filter()
        .nameContains(query, caseSensitive: false)
        .findAll();

    return SearchResult(
      books: books,
      authors: authors,
      issuedCopies: issuedCopies,
      borrowers: borrowers,
    );
  }
}
