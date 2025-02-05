import 'dart:io';

import 'package:isar/isar.dart';
import 'package:libertad/data/mock/mock_authors.dart';
import 'package:libertad/data/mock/mock_books.dart';
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
    // Get application documents directory to be used as the database.
    final Directory directory = await getApplicationDocumentsDirectory();
    // Load Isar instance with the relevant collections.
    _isar = await Isar.open(
      [BookSchema, AuthorSchema, BookCopySchema, BorrowerSchema],
      directory: directory.path,
    );
  }

  /// A stream of books data. Allows us to watch for changes in the books
  /// collection and update UI.
  Stream<void> get booksStream => _isar.books.watchLazy(fireImmediately: true);

  /// A stream of authors data. Allows us to watch for changes in the authors
  /// collection and update UI.
  Stream<void> get authorsStream =>
      _isar.authors.watchLazy(fireImmediately: true);

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
        await _isar.books.put(book);
        await _isar.authors.put(author);
        await book.author.save();
        await author.books.save();
      }
    });
  }

  /// Returns all the books in the collection.
  Future<List<Book>> getAllBooks() => _isar.books.where().findAll();

  /// Returns all the authors in the collection.
  Future<List<Author>> getAllAuthors() => _isar.authors.where().findAll();

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

  Future<bool> deleteBook(Book book) async {
    // Get book's author.
    final Author author = book.author.value!;
    // This is author's only book in the library.
    final bool authorsOnlyBook = author.books.length == 1;

    return await _isar.writeTxn<bool>(() async {
      // Delete author is this is their only book in the library.
      if (authorsOnlyBook) {
        await _isar.authors.delete(author.id);
      }
      // Delete the book from the database.
      return await _isar.books.delete(book.id);
    });
  }

  Future<List<Author>> searchAuthors(String name) async {
    return _isar.authors
        .filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }

  List<BookCopy> _generateCopies(Book book, int totalCopies) {
    return List.generate(
      totalCopies,
      (index) => BookCopy()..book.value = book,
    );
  }
}
