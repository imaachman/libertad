import 'package:isar/isar.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/book.dart';
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
import 'package:libertad/data/repositories/database_repository.dart';

/// Repository of methods that mocks a database.
class MockDatabaseRepository extends DatabaseRepository {
  MockDatabaseRepository();

  @override
  Future<void> initialize() async => throw UnimplementedError();

  @override
  Future<void> initializeForTest() async => throw UnimplementedError();

  // BEGIN: WATCHERS

  @override
  Stream<void> get booksStream => throw UnimplementedError();

  @override
  Stream<void> bookStream(Id id) => throw UnimplementedError();

  @override
  Stream<void> get authorsStream => throw UnimplementedError();

  @override
  Stream<void> authorStream(Id id) => throw UnimplementedError();

  @override
  Stream<void> get bookCopiesStream => throw UnimplementedError();

  @override
  Stream<void> bookCopyStream(Id id) => throw UnimplementedError();

  @override
  Stream<void> get borrowersStream => throw UnimplementedError();

  @override
  Stream<void> borrowerStream(Id id) => throw UnimplementedError();

  // END: WATCHERS

  // BEGIN: DATA FETCHERS

  @override
  Future<Book?> getBook(Id id) async => throw UnimplementedError();

  @override
  Future<Author?> getAuthor(Id id) async => throw UnimplementedError();

  @override
  Future<BookCopy?> getBookCopy(Id id) async => throw UnimplementedError();

  @override
  Future<Borrower?> getBorrower(Id id) async => throw UnimplementedError();

  @override
  Future<List<Book>> getBooks({
    BookSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    BookFilters filters = const BookFilters(),
  }) async =>
      throw UnimplementedError();

  @override
  Future<List<Author>> getAuthors({
    AuthorSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
  }) async =>
      throw UnimplementedError();

  @override
  Future<List<BookCopy>> getIssuedCopies({
    IssuedCopySort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    IssuedCopyFilters filters = const IssuedCopyFilters(),
  }) async =>
      throw UnimplementedError();

  @override
  Future<List<BookCopy>> getAllCopies() async => throw UnimplementedError();

  @override
  Future<List<Borrower>> getBorrowers({
    BorrowerSort? sortBy,
    SortOrder sortOrder = SortOrder.ascending,
    BorrowerFilters filters = const BorrowerFilters(),
  }) async =>
      throw UnimplementedError();

  // END: DATA FETCHERS

  // BEGIN: CREATION

  @override
  Future<void> addBook(Book book, Author author, int totalCopies) async =>
      throw UnimplementedError();

  @override
  Future<void> addBorrower(Borrower borrower) async =>
      throw UnimplementedError();

  // END: CREATION

  // BEGIN: UPDATION

  @override
  Future<void> updateBook(
          Book book, Author newAuthor, int newTotalCopies) async =>
      throw UnimplementedError();

  @override
  Future<void> updateAuthor(Author author) async => throw UnimplementedError();

  @override
  Future<void> updateBorrower(Borrower borrower) async =>
      throw UnimplementedError();

  // END: UPDATION

  // BEGIN: DELETION

  @override
  Future<bool> deleteBook(Book book) async => throw UnimplementedError();

  @override
  Future<bool> deleteAuthor(Author author) async => throw UnimplementedError();

  @override
  Future<bool> deleteBorrower(Borrower borrower) async =>
      throw UnimplementedError();

  // END: DELETION

  // BEGIN: LIBRARY TRANSACTIONS

  @override
  Future<void> issueCopy(BookCopy copy, Borrower borrower) async =>
      throw UnimplementedError();

  @override
  Future<void> returnCopy(BookCopy copy, Borrower borrower) async =>
      throw UnimplementedError();

  @override
  Future<void> acceptFine(Borrower borrower) async =>
      throw UnimplementedError();

  // END: LIBRARY TRANSACTIONS

  // BEGIN: SEARCH

  @override
  Future<List<Author>> searchAuthors(String name) async =>
      throw UnimplementedError();

  @override
  Future<List<Borrower>> searchBorrowers(String name,
          {bool active = false}) async =>
      throw UnimplementedError();

  @override
  Future<SearchResult> searchDatabase(String query) async =>
      throw UnimplementedError();

  // END: SEARCH

  // BEGIN: DEVELOPER OPTIONS

  @override
  Future<void> clearDatabase() async => throw UnimplementedError();

  @override
  Future<void> resetDatabase({deleteImages = true}) async =>
      throw UnimplementedError();

  // END: DEVELOPER OPTIONS
}
