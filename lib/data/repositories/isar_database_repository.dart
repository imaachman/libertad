import 'dart:io';
import 'dart:math';

import 'package:isar/isar.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/mock/mock_data.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/book_filters.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_filters.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/image_folder.dart';
import 'package:libertad/data/models/issue_status.dart';
import 'package:libertad/data/models/issued_copy_filters.dart';
import 'package:libertad/data/models/issued_copy_sort.dart';
import 'package:libertad/data/models/search_result.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:path_provider/path_provider.dart';

import '../models/author.dart';
import '../models/book.dart';

/// Repository of methods which we can use to interact with the Isar database.
class IsarDatabaseRepository extends DatabaseRepository {
  IsarDatabaseRepository();

  /// Isar instance used for database operations.
  late final Isar _isar;

  /// Initialize database.
  /// This method should be called before interacting with the database.
  /// Typically called in the [main] method before running the app.
  @override
  Future<void> initialize() async {
    // Get application documents directory.
    final Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    // Create sub-directory to use as app's database and file storage.
    final Directory appDirectory =
        await Directory('${applicationDocumentsDirectory.path}/Libertad')
            .create();
    // Load Isar instance with the relevant collections.
    _isar = await Isar.open(
      [BookSchema, AuthorSchema, BookCopySchema, BorrowerSchema],
      directory: appDirectory.path,
    );
  }

  /// Initialize database for testing.
  /// System temporary directory is to setup the database instead of actual
  /// app directory.
  /// This method should be called before interacting with the database.
  /// Typically called inside [setUp] method before running tests.
  @override
  Future<void> initializeForTest() async {
    // Get temporary directory.
    final Directory tempDirectory = await Directory.systemTemp.createTemp();
    // Initialize core database functionality.
    await Isar.initializeIsarCore(download: true);
    // If an instance isn't already open.
    if (Isar.instanceNames.isEmpty) {
      // Load Isar instance with the relevant collections.
      _isar = await Isar.open(
        [BookSchema, AuthorSchema, BookCopySchema, BorrowerSchema],
        directory: tempDirectory.path,
      );
    }
  }

  // BEGIN: WATCHERS

  /// A stream of books data. Allows us to watch for changes in the books
  /// collection and update UI.
  @override
  Stream<void> get booksStream => _isar.books.watchLazy(fireImmediately: true);

  /// A stream of book data. Allows us to watch for changes to a particular book
  /// from the collection and update UI.
  @override
  Stream<void> bookStream(Id id) =>
      _isar.books.watchObject(id, fireImmediately: true);

  /// A stream of authors data. Allows us to watch for changes in the authors
  /// collection and update UI.
  @override
  Stream<void> get authorsStream =>
      _isar.authors.watchLazy(fireImmediately: true);

  /// A stream of author data. Allows us to watch for changes to a particular
  /// author from the collection and update UI.
  @override
  Stream<void> authorStream(Id id) =>
      _isar.authors.watchObject(id, fireImmediately: true);

  /// A stream of book copies data. Allows us to watch for changes in the book
  /// copies collection and update UI.
  @override
  Stream<void> get bookCopiesStream =>
      _isar.bookCopys.watchLazy(fireImmediately: true);

  /// A stream of book copy data. Allows us to watch for changes to a particular
  /// book copy from the collection and update UI.
  @override
  Stream<void> bookCopyStream(Id id) =>
      _isar.bookCopys.watchObject(id, fireImmediately: true);

  /// A stream of borrowers data. Allows us to watch for changes in the
  /// borrowers collection and update UI.
  @override
  Stream<void> get borrowersStream =>
      _isar.borrowers.watchLazy(fireImmediately: true);

  /// A stream of borrower data. Allows us to watch for changes to a particular
  /// borrower from the collection and update UI.
  @override
  Stream<void> borrowerStream(Id id) =>
      _isar.borrowers.watchObject(id, fireImmediately: true);

  // END: WATCHERS

  // BEGIN: DATA FETCHERS

  /// Returns the book by [id]. (Used only in tests)
  @override
  Future<Book?> getBook(Id id) async => _isar.books.get(id);

  /// Returns the author by [id]. (Used only in tests)
  @override
  Future<Author?> getAuthor(Id id) async => _isar.authors.get(id);

  /// Returns the book copy by [id]. (Used only in tests)
  @override
  Future<BookCopy?> getBookCopy(Id id) async => _isar.bookCopys.get(id);

  /// Returns the borrower by [id]. (Used only in tests)
  @override
  Future<Borrower?> getBorrower(Id id) async => _isar.borrowers.get(id);

  /// Returns all the books from the collection, sorted by [sortBy],
  /// arranged according to [sortOrder], and filtered by combining the various
  /// [filters].
  @override
  Future<List<Book>> getBooks({
    BookSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    BookFilters filters = const BookFilters(),
  }) async {
    // Sort the books by index if [sortBy] parameter is indexible.
    final QueryBuilder<Book, Book, QAfterWhere>? indexSortedBooks =
        _getIndexSortedBooks(sortBy, sortOrder);
    // Filter the books by applying all the filter parameters defined in
    // [filters].
    final QueryBuilder<Book, Book, QAfterFilterCondition> filteredBooks =
        _getFilteredBooks(indexSortedBooks: indexSortedBooks, filters: filters);
    // Sort the books with Isar's sorting methods if [sortBy] parameter is
    // non-indexible.
    final List<Book> books =
        await _getSortedBooks(filteredBooks, sortBy, sortOrder);
    return books;
  }

  /// Returns all the authors from the collection, sorted by [sortBy] and
  /// arranged according to [sortOrder].
  @override
  Future<List<Author>> getAuthors({
    AuthorSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
  }) async {
    // Retrieve all authors from the collection and sort by either index or via
    // Isar's sorting methods depending on whether the parameter is indexible or
    // not.
    switch (sortBy) {
      // Sort by author's name. (using database methods)
      case AuthorSort.name:
        if (sortOrder == SortOrder.ascending) {
          return _isar.authors.where().sortByName().findAll();
        } else {
          return _isar.authors.where().sortByNameDesc().findAll();
        }
      // Sort by author's creation date. (using `where` clause)
      case AuthorSort.dateAdded:
        return _isar.authors
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyCreatedAt()
            .findAll();
      // Sort by author's updation date. (using `where` clause)
      case AuthorSort.dateModified:
        return _isar.authors
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyUpdatedAt()
            .findAll();
      default:
        return _isar.authors.where().findAll();
    }
  }

  /// Returns all the issued copies from the [bookCopys] collection, sorted by
  /// [sortBy], arranged according to [sortOrder], and filtered by combining the
  /// various filter parameters.
  @override
  Future<List<BookCopy>> getIssuedCopies({
    IssuedCopySort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    IssuedCopyFilters filters = const IssuedCopyFilters(),
  }) async {
    // Sort the issued copies by index.
    final QueryBuilder<BookCopy, BookCopy, QAfterWhere>?
        indexSortedIssuedCopies =
        _getIndexSortedIssuedCopies(sortBy, sortOrder);
    // Filter the issued copies by applying all the filter parameters defined in
    // [filters].
    final QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
        filteredIssuedCopies = _getFilteredIssuedCopies(
      indexSortedIssuedCopies: indexSortedIssuedCopies,
      filters: filters,
    );
    return filteredIssuedCopies.findAll();
  }

  /// Returns all the copies from the [bookCopys] collection.
  /// (Used only in tests)
  @override
  Future<List<BookCopy>> getAllCopies() async {
    return _isar.bookCopys.where().findAll();
  }

  /// Returns all the borrowers from the collection, sorted by [sortBy],
  /// arranged according to [sortOrder], and filtered by combining the various
  /// filter parameters.
  @override
  Future<List<Borrower>> getBorrowers({
    BorrowerSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    BorrowerFilters filters = const BorrowerFilters(),
  }) async {
    // Sort the borrowers by index if [sortBy] parameter is indexible.
    final QueryBuilder<Borrower, Borrower, QAfterWhere>? indexSortedBorrowers =
        _getIndexSortedBorrowers(sortBy, sortOrder);
    // Filter the borrowers by applying all the filter parameters defined in
    // [filters].
    final QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
        filteredBorrowers = _getFilteredBorrowers(
            indexSortedBorrowers: indexSortedBorrowers, filters: filters);
    // Sort the borrowers with Isar's sorting methods if [sortBy] parameter is
    // non-indexible.
    final List<Borrower> borrowers =
        await _getSortedBorrowers(filteredBorrowers, sortBy, sortOrder);
    return borrowers;
  }

  // END: DATA FETCHERS

  // BEGIN: CREATION

  /// Adds a new book to the collection.
  ///
  /// [author] and [totalCopies] are required because they are [IsarLinks] and
  /// we need to create them before adding them to the [Book] object.
  ///
  /// If the author is not present in the database, it will be added.
  /// And [totalCopies] number of [BookCopy] objects will be created, linked to
  /// the [Book] object, and saved to the database.
  @override
  Future<void> addBook(Book book, Author author, int totalCopies) async {
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

  /// Adds a new borrower to the collection.
  @override
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

  // END: CREATION

  // BEGIN: UPDATION

  /// Updates an existing book in the collection.
  ///
  /// In case the author is changed:
  /// 1. If the old author has only one book in the library, delete the author.
  /// 2. If the new author is not present in the database, add it.
  ///
  /// In case the total copies are changed:
  /// 1. If the new total copies are more than the old total copies, create the
  ///   new copies and add them to the database.
  /// 2. If the new total copies are less than the old total copies, delete all
  ///   the copies and replace them with the new copies. We don't want to
  ///   update the existing copies because they might have been borrowed.
  @override
  Future<void> updateBook(
      Book book, Author newAuthor, int newTotalCopies) async {
    // Get the old author.
    final Author oldAuthor = book.author.value!;
    // If author updated.
    final bool authorUpdated = oldAuthor != newAuthor;
    // If this is old author's only book in the library.
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
        if (newAuthorNotPresent) {
          // Update creation and updation time right before adding the new
          // author to the database.
          newAuthor
            ..createdAt = DateTime.now()
            ..updatedAt = DateTime.now();
          await _isar.authors.put(newAuthor);
        }

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

  /// Updates an existing author in the collection.
  @override
  Future<void> updateAuthor(Author author) async {
    await _isar.writeTxn(() async {
      // Update author update time right before it's inserted in the database.
      author.updatedAt = DateTime.now();
      _isar.authors.put(author);
    });
  }

  /// Updates an existing borrower in the collection.
  @override
  Future<void> updateBorrower(Borrower borrower) async {
    await _isar.writeTxn(() async {
      // Update borrower update time right before it's inserted in the database.
      borrower.updatedAt = DateTime.now();
      // Update the borrower in the database.
      await _isar.borrowers.put(borrower);
    });
  }

  // END: UPDATION

  // BEGIN: DELETION

  /// Deletes the book from the collection.
  /// All of book's copies are un-issued and deleted.
  /// If this is author's only book, the author is deleted as well.
  @override
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

  /// Deletes the author and their books (along with all the copies of book).
  @override
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

  /// Deletes the borrower from the collection.
  /// All the books issued by the borrower are made available.
  @override
  Future<bool> deleteBorrower(Borrower borrower) async {
    return await _isar.writeTxn<bool>(() async {
      // Load copies link from the database.
      await borrower.currentlyIssuedBooks.load();
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

  // END: DELETION

  // BEGIN: LIBRARY TRANSACTIONS

  /// Issues the copy to the borrower.
  @override
  Future<void> issueCopy(BookCopy copy, Borrower borrower) async {
    return _isar.writeTxn(() async {
      // Link the borrower to the copy.
      copy.currentBorrower.value = borrower;
      // Update the copy in the database.
      await _isar.bookCopys.put(copy);
      // Save the link.
      copy.currentBorrower.save();
    });
  }

  /// Marks the issued copy as returned.
  @override
  Future<void> returnCopy(BookCopy copy, Borrower borrower) async {
    return _isar.writeTxn(() async {
      // Return copy by resetting the borrower link.
      copy.currentBorrower.reset();
      // If returned copy was overdue, we update borrower with defaulter status
      // and fine.
      // [borrower] object already have them updated, we just need to
      // update it in the database.
      await _isar.borrowers.put(borrower);
      // Add the borrower to the copy's previous borrowers set.
      copy.previousBorrowers.add(borrower);
      // Update the copy in the database.
      await _isar.bookCopys.put(copy);
      // Save current and previous borrowers links.
      copy.currentBorrower.save();
      copy.previousBorrowers.save();
    });
  }

  /// Accept fine and mark the borrower as non-defaulter.
  @override
  Future<void> acceptFine(Borrower borrower) async {
    return _isar.writeTxn(() async {
      // [borrower] object already has the updated defaulter status and fine set
      // to 0. So we just need to update it in the database.
      await _isar.borrowers.put(borrower);
    });
  }

  // END: LIBRARY TRANSACTIONS

  // BEGIN: INDEX SORTING

  /// Indexible fields marked by [Index()] are pre-sorted in the index table.
  /// So, we can retrieve the sorted books list using `where` clauses. No need
  /// to manually sort with Isar's sorting methods.
  QueryBuilder<Book, Book, QAfterWhere>? _getIndexSortedBooks(
      BookSort? sortBy, SortOrder sortOrder) {
    // Sort books according to indexible [sortBy] parameter and order them by
    // [sortOrder].
    switch (sortBy) {
      // Sort by book's release date.
      case BookSort.releaseDate:
        return _isar.books
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyReleaseDate();
      // Sort by book's creation date.
      case BookSort.dateAdded:
        return _isar.books
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyCreatedAt();
      // Sort by book's updation date.
      case BookSort.dateModified:
        return _isar.books
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyUpdatedAt();
      // For rest of the parameters, do not sort. They will be manually sorted
      // later in the query, after filtering the books.
      case BookSort.title:
      case BookSort.totalCopies:
      case BookSort.issuedCopies:
      default:
        return null;
    }
  }

  /// Indexible fields marked by [Index()] are pre-sorted in the index table.
  /// So, we can retrieve the sorted issued copies list using `where` clauses.
  /// No need to manually sort with Isar's sorting methods.
  QueryBuilder<BookCopy, BookCopy, QAfterWhere>? _getIndexSortedIssuedCopies(
      IssuedCopySort? sortBy, SortOrder sortOrder) {
    // Sort issued copies according to indexible [sortBy] parameter and order
    // them by [sortOrder].
    switch (sortBy) {
      // Sort by copy's issue date.
      case IssuedCopySort.issueDate:
        return _isar.bookCopys
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyIssueDate();
      // Sort by copy's return date.
      case IssuedCopySort.returnDate:
        return _isar.bookCopys
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyReturnDate();
      default:
        return null;
    }
  }

  /// Indexible fields marked by [Index()] are pre-sorted in the index table.
  /// So, we can retrieve the sorted borrowers list using `where` clauses.
  /// No need to manually sort with Isar's sorting methods.
  QueryBuilder<Borrower, Borrower, QAfterWhere>? _getIndexSortedBorrowers(
      BorrowerSort? sortBy, SortOrder sortOrder) {
    // Sort borrowers according to indexible [sortBy] parameter and order them
    // by [sortOrder].
    switch (sortBy) {
      // Sort by borrower's membership start date.
      case BorrowerSort.membershipStartDate:
        return _isar.borrowers
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyMembershipStartDate();
      // Sort by borrower's creation date.
      case BorrowerSort.dateAdded:
        return _isar.borrowers
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyCreatedAt();
      // Sort by borrower's updation date.
      case BorrowerSort.dateModified:
        return _isar.borrowers
            .where(
                sort: sortOrder == SortOrder.ascending ? Sort.asc : Sort.desc)
            .anyUpdatedAt();
      // Do not sort for [name] because it will manually be sorted later in the
      // query, after filtering the borrowers.
      case BorrowerSort.name:
      default:
        return null;
    }
  }

  // END: INDEX SORTING

  // BEGIN: MANUAL SORTING

  /// Sorts the books manually using Isar's sorting methods. This is the last
  /// step in the query after `where` clause sorting and filtering.
  Future<List<Book>> _getSortedBooks(
    QueryBuilder<Book, Book, QAfterFilterCondition> filteredBooks,
    BookSort? sortBy,
    SortOrder sortOrder,
  ) async {
    // Sort books according to [sortBy] parameter and order them by [sortOrder]
    // using Isar's sorting methods.
    switch (sortBy) {
      // Sort the books by title.
      case BookSort.title:
        if (sortOrder == SortOrder.ascending) {
          return filteredBooks.sortByTitle().findAll();
        } else {
          return filteredBooks.sortByTitleDesc().findAll();
        }
      // Sort the books by number of total copies.
      case BookSort.totalCopies:
        final List<Book> books = await filteredBooks.findAll();
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
        final List<Book> books = await filteredBooks.findAll();
        books.sort((a, b) {
          if (sortOrder == SortOrder.ascending) {
            return a.issuedCopies.length.compareTo(b.issuedCopies.length);
          } else {
            return b.issuedCopies.length.compareTo(a.issuedCopies.length);
          }
        });
        return books;
      // No need to sort for release date, creation and updation date/time
      // because the books are already sorted by index.
      case BookSort.releaseDate:
      case BookSort.dateAdded:
      case BookSort.dateModified:
      default:
        return filteredBooks.findAll();
    }
  }

  /// Sorts the borrowers manually using Isar's sorting methods. This is the last
  /// step in the query after `where` clause sorting and filtering.
  Future<List<Borrower>> _getSortedBorrowers(
    QueryBuilder<Borrower, Borrower, QAfterFilterCondition> filteredBorrowers,
    BorrowerSort? sortBy,
    SortOrder sortOrder,
  ) async {
    // Sort borrowers according to [sortBy] parameter and order them by
    // [sortOrder] using Isar's sorting methods.
    switch (sortBy) {
      // Sort the borrowers by name.
      case BorrowerSort.name:
        if (sortOrder == SortOrder.ascending) {
          return filteredBorrowers.sortByName().findAll();
        } else {
          return filteredBorrowers.sortByNameDesc().findAll();
        }
      // No need to sort for membership start date, creation and updation
      // date/time because the borrowers are already sorted by index.
      case BorrowerSort.membershipStartDate:
      case BorrowerSort.dateAdded:
      case BorrowerSort.dateModified:
      default:
        return filteredBorrowers.findAll();
    }
  }

  // END: MANUAL SORTING

  // BEGIN: FILTERS

  /// Filters books by combining all the filters defined in [filters] parameter.
  QueryBuilder<Book, Book, QAfterFilterCondition> _getFilteredBooks({
    required BookFilters filters,
    QueryBuilder<Book, Book, QAfterWhere>? indexSortedBooks,
  }) {
    // Filter query is appended after sorting books by index. If books aren't
    // being sorted by index, we build the filter query directly.
    final QueryBuilder<Book, Book, QFilterCondition> queryBuilder;
    if (indexSortedBooks == null) {
      queryBuilder = _isar.books.filter();
    } else {
      queryBuilder = indexSortedBooks.filter();
    }
    // Apply the relevant filters conditionally using the [optional] query
    // method.
    return queryBuilder
        // Filter by genre.
        .optional(filters.genreFilter != null,
            (book) => book.genreEqualTo(filters.genreFilter!))
        // Filter by author.
        .optional(
            filters.authorFilter != null,
            (book) => book
                .author((author) => author.idEqualTo(filters.authorFilter!.id)))
        // Filter by oldest release date.
        .optional(
            filters.oldestReleaseDateFilter != null,
            (book) =>
                book.releaseDateGreaterThan(filters.oldestReleaseDateFilter!))
        // Filter by newest release date.
        .optional(
            filters.newestReleaseDateFilter != null,
            (book) =>
                book.releaseDateLessThan(filters.newestReleaseDateFilter!))
        // Filter by availability.
        .optional(filters.issueStatusFilter != null, (book) {
          if (filters.issueStatusFilter!.isAvailable) {
            // Show available books, i.e., books with at least one available
            // copy.
            return book.totalCopies(
                (copy) => copy.statusEqualTo(IssueStatus.available));
          } else {
            // Show unavailable books, i.e., books with all copies issued.
            return book.not().totalCopies(
                (copy) => copy.statusEqualTo(IssueStatus.available));
          }
        })
        // Filter by minimum number of total copies.
        .optional(
            filters.minCopiesFilter != null,
            (book) =>
                book.totalCopiesLengthGreaterThan(filters.minCopiesFilter!))
        // Filter by maximum number of total copies.
        .optional(filters.maxCopiesFilter != null,
            (book) => book.totalCopiesLengthLessThan(filters.maxCopiesFilter!));
  }

  /// Filters issued copies by combining all the filters defined in [filters]
  /// parameter.
  QueryBuilder<BookCopy, BookCopy, QAfterFilterCondition>
      _getFilteredIssuedCopies({
    required IssuedCopyFilters filters,
    QueryBuilder<BookCopy, BookCopy, QAfterWhere>? indexSortedIssuedCopies,
  }) {
    // Filter query is appended after sorting issued copies by index. If the
    // copies aren't being sorted by index, we build the filter query directly.
    final QueryBuilder<BookCopy, BookCopy, QFilterCondition> queryBuilder;
    if (indexSortedIssuedCopies == null) {
      queryBuilder = _isar.bookCopys.filter();
    } else {
      queryBuilder = indexSortedIssuedCopies.filter();
    }
    // Apply the relevant filters conditionally using the [optional] query
    // method.
    return queryBuilder
        // Apply issue status filter.
        .statusEqualTo(IssueStatus.issued)
        // Filter by book.
        .optional(
          filters.bookFilter != null,
          (copy) => copy.book(
            (book) => book.idEqualTo(filters.bookFilter!.id),
          ),
        )
        // Filter by borrower.
        .optional(filters.borrowerFilter != null, (copy) {
          return copy.currentBorrower((borrower) {
            return borrower.idEqualTo(filters.borrowerFilter!.id);
          });
        })
        // Filter by whether the copy is overdue.
        .optional(filters.overdueFilter != null, (copy) {
          if (filters.overdueFilter!) {
            return copy.returnDateLessThan(DateTime.now());
          } else {
            return copy.returnDateGreaterThan(DateTime.now());
          }
        })
        // Filter by oldest issue date.
        .optional(
          filters.oldestIssueDateFilter != null,
          (book) => book.issueDateGreaterThan(filters.oldestIssueDateFilter!),
        )
        // Filter by newest issue date.
        .optional(
          filters.newestIssueDateFilter != null,
          (book) => book.issueDateLessThan(filters.newestIssueDateFilter!),
        )
        // Filter by oldest return date.
        .optional(
          filters.oldestReturnDateFilter != null,
          (book) => book.returnDateGreaterThan(filters.oldestReturnDateFilter!),
        )
        // Filter by newest return date.
        .optional(
          filters.newestReturnDateFilter != null,
          (book) => book.returnDateLessThan(filters.newestReturnDateFilter!),
        );
  }

  /// Filters borrowers by combining all the filters defined in [filters]
  /// parameter.
  QueryBuilder<Borrower, Borrower, QAfterFilterCondition>
      _getFilteredBorrowers({
    required BorrowerFilters filters,
    QueryBuilder<Borrower, Borrower, QAfterWhere>? indexSortedBorrowers,
  }) {
    // Filter query is appended after sorting borrowers by index. If borrowers
    // aren't being sorted by index, we build the filter query directly.
    final QueryBuilder<Borrower, Borrower, QFilterCondition> queryBuilder;
    if (indexSortedBorrowers == null) {
      queryBuilder = _isar.borrowers.filter();
    } else {
      queryBuilder = indexSortedBorrowers.filter();
    }
    // Apply the relevant filters conditionally using the [optional] query
    // method.
    return queryBuilder
        // Filter by whether the borrower is an active member.
        .optional(filters.activeFilter != null, (borrower) {
      if (filters.activeFilter!) {
        // Borrower is active if their membership end date is after today.
        return borrower.membershipEndDateGreaterThan(DateTime.now());
      } else {
        // Borrower is inactive if their membership end date is before today.
        return borrower.membershipEndDateLessThan(DateTime.now());
      }
    })
        // Filter by whether the borrower is a defaulter.
        .optional(filters.defaulterFilter != null, (borrower) {
      if (filters.defaulterFilter!) {
        return borrower.isDefaulterEqualTo(true);
      } else {
        return borrower.isDefaulterEqualTo(false);
      }
    })
        // Filter by oldest membership start date.
        .optional(filters.oldestMembershipStartDateFilter != null, (book) {
      return book.membershipStartDateGreaterThan(
          filters.oldestMembershipStartDateFilter!);
    })
        // Filter by newest membership start date.
        .optional(filters.newestMembershipStartDateFilter != null, (book) {
      return book.membershipStartDateLessThan(
          filters.newestMembershipStartDateFilter!);
    });
  }

  // END: FILTERS

  // BEGIN: SEARCH

  /// Searches through the authors in the collection by their name.
  @override
  Future<List<Author>> searchAuthors(String name) async {
    return _isar.authors
        .filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }

  /// Searches through the borrowers in the collection by their name.
  /// An optional [active] parameter enables us to search through only active
  /// borrowers.
  @override
  Future<List<Borrower>> searchBorrowers(String name,
      {bool active = false}) async {
    // Filter by borrower's name.
    final QueryBuilder<Borrower, Borrower, QAfterFilterCondition> queryBuilder =
        _isar.borrowers.filter().nameContains(name, caseSensitive: false);
    if (active == true) {
      // Filter active status by checking if membership end date is after today.
      return queryBuilder
          .membershipEndDateGreaterThan(DateTime.now())
          .findAll();
    } else {
      return queryBuilder.findAll();
    }
  }

  /// Searches through the database by filtering based on the provided [query].
  @override
  Future<SearchResult> searchDatabase(String query) async {
    // Filter books by matching [query] with their title and author's name.
    final List<Book> books = await _isar.books
        .filter()
        .titleContains(query, caseSensitive: false)
        .or()
        .author((q) => q.nameContains(query, caseSensitive: false))
        .findAll();
    // Filter authors by matching [query] with their name and books' title.
    final List<Author> authors = await _isar.authors
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .books((q) => q.titleContains(query, caseSensitive: false))
        .findAll();
    // Filter issued copies by matching [query] with their book's title.
    final List<BookCopy> issuedCopies = await _isar.bookCopys
        .filter()
        .statusEqualTo(IssueStatus.issued)
        .and()
        .book((q) => q.titleContains(query, caseSensitive: false))
        .findAll();
    // Filter borrowers by matching [query] with their name.
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

  // END: SEARCH

  // BEGIN: DEVELOPER OPTIONS

  /// Clears entire database. (for development purposes only)
  @override
  Future<void> clearDatabase() async {
    await _isar.writeTxn(() async {
      // Clear database.
      await _isar.clear();
    });
  }

  /// Resets database to its original state with mock data.
  /// Random number of copies are generated for each [Book] object.
  /// User images (book covers and profile pictures) are deleted as well.
  /// (for development purposes only)
  @override
  Future<void> resetDatabase({deleteImages = true}) async {
    await _isar.writeTxn(() async {
      // Clear database.
      await _isar.clear();
      // Delete all the images stored in the app's image directories.
      if (deleteImages) {
        await FilesRepository.instance
            .deleteImageFolder(ImageFolder.bookCovers);
        await FilesRepository.instance
            .deleteImageFolder(ImageFolder.authorProfilePictures);
        await FilesRepository.instance
            .deleteImageFolder(ImageFolder.borrowerProfilePictures);
      }
      // Populate books and authors data.
      for (int index = 0; index < MockData.books.length; index++) {
        // Need to create a new copy of the [Book] and [Author] object every
        // time because otherwise we'll be reassigning already initialized links
        // to different objects. And it is illegal to move a link to another
        // object.
        final Book book = MockData.books[index].copyWith();
        final Author author = MockData.authors[index].copyWith();
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
      for (int index = 0; index < MockData.borrowers.length; index++) {
        final Borrower borrower = MockData.borrowers[index].copyWith();
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

  // END: DEVELOPER OPTIONS

  // BEGIN: HELPER METHODS

  /// Generates [totalCopies] number of [BookCopy] objects and links each of
  /// them to the provided [book] object.
  List<BookCopy> _generateCopies(Book book, int totalCopies) {
    return List.generate(
      totalCopies,
      (index) => BookCopy()..book.value = book,
    );
  }

  // END: HELPER METHODS
}
