import 'dart:io';

import 'package:isar/isar.dart';
import 'package:libertad/data/mock/mock_authors.dart';
import 'package:libertad/data/mock/mock_books.dart';
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
      [BookSchema, AuthorSchema],
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
  Future<void> addBook(Book book) async {
    await _isar.writeTxn(() async {
      await _isar.books.put(book);
    });
  }

  Future<List<Author>> searchAuthors(String name) async {
    return _isar.authors
        .filter()
        .nameContains(name, caseSensitive: false)
        .findAll();
  }
}
