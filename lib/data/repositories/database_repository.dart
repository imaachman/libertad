import 'dart:io';
import 'dart:math';

import 'package:isar/isar.dart';
import 'package:libertad/data/mock/mock_authors.dart';
import 'package:libertad/data/mock/mock_books.dart';
import 'package:libertad/data/mock/mock_borrowers.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/borrower.dart';
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
      await _isar.clear();
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

        // Add the book and author to the database.
        await _isar.books.put(book);
        await _isar.authors.put(author);

        // Save the book, book copies, and author links.
        // Always the last step, required to update the links in the database.
        await book.author.save();
        await book.totalCopies.save();
        await author.books.save();
      }
      // Add all the borrowers to the database.
      await _isar.borrowers.putAll(mockBorrowers);
    });
  }

  /// Returns all the books in the collection.
  Future<List<Book>> getAllBooks() => _isar.books.where().findAll();

  /// Returns all the authors in the collection.
  Future<List<Author>> getAllAuthors() => _isar.authors.where().findAll();

  /// Returns the issued book copies from the collection.
  Future<List<BookCopy>> getIssuedCopies() =>
      _isar.bookCopys.filter().statusEqualTo(IssueStatus.issued).findAll();

  /// Returns all the borrowers in the collection.
  Future<List<Borrower>> getAllBorrowers() => _isar.borrowers.where().findAll();

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
      if (authorNotPresent) await _isar.authors.put(author);
      // Link the author to the book.
      book.author.value = author;

      // Create [totalCopies] number of [BookCopy] objects.
      // Each copy will have a link to the book.
      final List<BookCopy> copies = _generateCopies(book, totalCopies);
      // Add the copies to the database.
      await _isar.bookCopys.putAll(copies);
      // Link the copies set to the book.
      book.totalCopies.addAll(copies);

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
        // Link the copies set to the book.
        book.totalCopies.addAll(copies);
      }

      // Update the book in the database.
      await _isar.books.put(book);

      // Save the author and copies links. Always the last step, required to
      // update the links in the database.
      if (authorUpdated) await book.author.save();
      if (totalCopiesChanged) await book.totalCopies.save();
    });
  }

  // TODO: Delete all copies before deleting the book.
  Future<bool> deleteBook(Book book) async {
    // Get book's author.
    final Author author = book.author.value!;
    // This is author's only book in the library.
    final bool authorsOnlyBook = author.books.length == 1;

    return await _isar.writeTxn<bool>(() async {
      // Delete author is this is their only book in the library.
      if (authorsOnlyBook) await _isar.authors.delete(author.id);

      // Delete the book from the database.
      return await _isar.books.delete(book.id);
    });
  }

  Future<void> updateAuthor(Author author) async {
    await _isar.writeTxn(() async {
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
      // Add the borrower to the database.
      await _isar.borrowers.put(borrower);
    });
  }

  /// Updates an existing borrower in the collection.
  Future<void> updateBorrower(Borrower borrower) async {
    await _isar.writeTxn(() async {
      // Update the borrower in the database.
      await _isar.borrowers.put(borrower);
    });
  }

  /// Deletes the borrower.
  Future<bool> deleteBorrower(Borrower borrower) async {
    return await _isar.writeTxn<bool>(() async {
      return await _isar.borrowers.delete(borrower.id);
    });
  }

  Future<List<Borrower>> searchBorrowers(String name) async {
    return _isar.borrowers
        .filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }

  Future<void> issueCopy(BookCopy copy, Borrower borrower) async {
    return _isar.writeTxn(() async {
      copy.currentBorrower.value = borrower;
      await _isar.bookCopys.put(copy);
      copy.currentBorrower.save();
    });
  }

  List<BookCopy> _generateCopies(Book book, int totalCopies) {
    return List.generate(
      totalCopies,
      (index) => BookCopy()..book.value = book,
    );
  }
}
