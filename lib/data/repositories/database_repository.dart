import 'dart:io';

import 'package:isar/isar.dart';
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

  Future<void> clearDatabase() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }

  Future<void> resetDatabase() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
      await _isar.books.putAll(mockBooks);
    });
  }

  Future<List<Book>> getAllBooks() {
    return _isar.books.where().findAll();
  }

  Future<List<Author>> getAllAuthors() {
    return _isar.authors.where().findAll();
  }
}
