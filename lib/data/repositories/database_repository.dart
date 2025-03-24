import 'package:isar/isar.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/book_filters.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_filters.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/issued_copy_filters.dart';
import 'package:libertad/data/models/issued_copy_sort.dart';
import 'package:libertad/data/models/search_result.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/isar_database_repository.dart';
import 'package:libertad/data/repositories/mock_database_repository.dart';

import '../models/author.dart';
import '../models/book.dart';

/// Repository of methods which we can use to interact with the database.
class DatabaseRepository {
  DatabaseRepository();

  /// Private constructor to create a singleton.
  DatabaseRepository._internal();

  /// We use this instance to provide access to the database repository
  /// across the app.
  static final DatabaseRepository instance = DatabaseRepository._internal();

  /// Allows selecting mock database repository. Used in starter project.
  bool useMock = false;
  void selectMockDatabase() => useMock = true;

  /// Selected database repository based on [useMock].
  late final DatabaseRepository _database;

  /// Initialize database.
  /// This method should be called before interacting with the database.
  /// Typically called in the [main] method before running the app.
  Future<void> initialize() async {
    if (useMock) {
      _database = MockDatabaseRepository();
    } else {
      _database = IsarDatabaseRepository();
    }
    return await _database.initialize();
  }

  /// Initialize database for testing.
  /// System temporary directory is to setup the database instead of actual
  /// app directory.
  /// This method should be called before interacting with the database.
  /// Typically called inside [setUp] method before running tests.
  Future<void> initializeForTest() async => _database.initializeForTest();

  // BEGIN: WATCHERS

  /// A stream of books data. Allows us to watch for changes in the books
  /// collection and update UI.
  Stream<void> get booksStream => _database.booksStream;

  /// A stream of book data. Allows us to watch for changes to a particular book
  /// from the collection and update UI.
  Stream<void> bookStream(Id id) => _database.bookStream(id);

  /// A stream of authors data. Allows us to watch for changes in the authors
  /// collection and update UI.
  Stream<void> get authorsStream => _database.authorsStream;

  /// A stream of author data. Allows us to watch for changes to a particular
  /// author from the collection and update UI.
  Stream<void> authorStream(Id id) => _database.authorStream(id);

  /// A stream of book copies data. Allows us to watch for changes in the book
  /// copies collection and update UI.
  Stream<void> get bookCopiesStream => _database.bookCopiesStream;

  /// A stream of book copy data. Allows us to watch for changes to a particular
  /// book copy from the collection and update UI.
  Stream<void> bookCopyStream(Id id) => _database.bookCopyStream(id);

  /// A stream of borrowers data. Allows us to watch for changes in the
  /// borrowers collection and update UI.
  Stream<void> get borrowersStream => _database.borrowersStream;

  /// A stream of borrower data. Allows us to watch for changes to a particular
  /// borrower from the collection and update UI.
  Stream<void> borrowerStream(Id id) => _database.borrowerStream(id);

  // END: WATCHERS

  // BEGIN: DATA FETCHERS

  /// Returns the book by [id]. (Used only in tests)
  Future<Book?> getBook(Id id) async => _database.getBook(id);

  /// Returns the author by [id]. (Used only in tests)
  Future<Author?> getAuthor(Id id) async => _database.getAuthor(id);

  /// Returns the book copy by [id]. (Used only in tests)
  Future<BookCopy?> getBookCopy(Id id) async => _database.getBookCopy(id);

  /// Returns the borrower by [id]. (Used only in tests)
  Future<Borrower?> getBorrower(Id id) async => _database.getBorrower(id);

  /// Returns all the books from the collection, sorted by [sortBy],
  /// arranged according to [sortOrder], and filtered by combining the various
  /// [filters].
  Future<List<Book>> getBooks({
    BookSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    BookFilters filters = const BookFilters(),
  }) =>
      _database.getBooks(
        sortBy: sortBy,
        sortOrder: sortOrder,
        filters: filters,
      );

  /// Returns all the authors from the collection, sorted by [sortBy] and
  /// arranged according to [sortOrder].
  Future<List<Author>> getAuthors({
    AuthorSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
  }) =>
      _database.getAuthors(
        sortBy: sortBy,
        sortOrder: sortOrder,
      );

  /// Returns all the issued copies from the [bookCopys] collection, sorted by
  /// [sortBy], arranged according to [sortOrder], and filtered by combining the
  /// various filter parameters.
  Future<List<BookCopy>> getIssuedCopies({
    IssuedCopySort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    IssuedCopyFilters filters = const IssuedCopyFilters(),
  }) =>
      _database.getIssuedCopies(
        sortBy: sortBy,
        sortOrder: sortOrder,
        filters: filters,
      );

  /// Returns all the copies from the [bookCopys] collection.
  /// (Used only in tests)
  Future<List<BookCopy>> getAllCopies() => _database.getAllCopies();

  /// Returns all the borrowers from the collection, sorted by [sortBy],
  /// arranged according to [sortOrder], and filtered by combining the various
  /// filter parameters.
  Future<List<Borrower>> getBorrowers({
    BorrowerSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    BorrowerFilters filters = const BorrowerFilters(),
  }) =>
      _database.getBorrowers(
        sortBy: sortBy,
        sortOrder: sortOrder,
        filters: filters,
      );

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
  Future<void> addBook(Book book, Author author, int totalCopies) =>
      _database.addBook(book, author, totalCopies);

  /// Adds a new borrower to the collection.
  Future<void> addBorrower(Borrower borrower) =>
      _database.addBorrower(borrower);

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
  Future<void> updateBook(Book book, Author newAuthor, int newTotalCopies) =>
      _database.updateBook(book, newAuthor, newTotalCopies);

  /// Updates an existing author in the collection.
  Future<void> updateAuthor(Author author) => _database.updateAuthor(author);

  /// Updates an existing borrower in the collection.
  Future<void> updateBorrower(Borrower borrower) =>
      _database.updateBorrower(borrower);

  // END: UPDATION

  // BEGIN: DELETION

  /// Deletes the book from the collection.
  /// All of book's copies are un-issued and deleted.
  /// If this is author's only book, the author is deleted as well.
  Future<bool> deleteBook(Book book) => _database.deleteBook(book);

  /// Deletes the author and their books (along with all the copies of book).
  Future<bool> deleteAuthor(Author author) => _database.deleteAuthor(author);

  /// Deletes the borrower from the collection.
  /// All the books issued by the borrower are made available.
  Future<bool> deleteBorrower(Borrower borrower) =>
      _database.deleteBorrower(borrower);

  // END: DELETION

  // BEGIN: LIBRARY TRANSACTIONS

  /// Issues the copy to the borrower.
  Future<void> issueCopy(BookCopy copy, Borrower borrower) =>
      _database.issueCopy(copy, borrower);

  /// Marks the issued copy as returned.
  Future<void> returnCopy(BookCopy copy, Borrower borrower) =>
      _database.returnCopy(copy, borrower);

  /// Accept fine and mark the borrower as non-defaulter.
  Future<void> acceptFine(Borrower borrower) => _database.acceptFine(borrower);

  // END: LIBRARY TRANSACTIONS

  // BEGIN: SEARCH

  /// Searches through the authors in the collection by their name.
  Future<List<Author>> searchAuthors(String name) =>
      _database.searchAuthors(name);

  /// Searches through the borrowers in the collection by their name.
  /// An optional [active] parameter enables us to search through only active
  /// borrowers.
  Future<List<Borrower>> searchBorrowers(String name, {bool active = false}) =>
      _database.searchBorrowers(name, active: active);

  /// Searches through the database by filtering based on the provided [query].
  Future<SearchResult> searchDatabase(String query) =>
      _database.searchDatabase(query);

  // END: SEARCH

  // BEGIN: DEVELOPER OPTIONS

  /// Clears entire database. (for development purposes only)
  Future<void> clearDatabase() => _database.clearDatabase();

  /// Resets database to its original state with mock data.
  /// Random number of copies are generated for each [Book] object.
  /// User images (book covers and profile pictures) are deleted as well.
  /// (for development purposes only)
  Future<void> resetDatabase({bool deleteImages = true}) =>
      _database.resetDatabase(deleteImages: deleteImages);

  /// Generates 1000 [Borrower] and [Author] objects and 2-5 [Book] models for
  /// each [Author]. Each book can have 1-15 [BookCopy] objects linked to it.
  /// Then, the function inserts this data into the database.
  Future<void> hyperPopulateDatabase() => _database.hyperPopulateDatabase();

  // END: DEVELOPER OPTIONS
}
