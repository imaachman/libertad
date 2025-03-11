import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'books_list_viewmodel.g.dart';

@riverpod
class BooksListViewModel extends _$BooksListViewModel {
  SortOrder selectedSortOrder = SortOrder.ascending;
  BookSort? bookSort;

  Genre? genreFilter;
  Author? authorFilter;
  IssueStatus? issueStatusFilter;
  int? minCopiesFilter;
  int? maxCopiesFilter;

  /// Used to show as options in the author filter.
  List<Author> allAuthors = [];

  @override
  Future<List<Book>> build() async {
    List<Book> books = [];
    // Listen for changes in books collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.booksStream.listen((_) async {
      // Retrieve all books from the database.
      books = await DatabaseRepository.instance.getAllBooks(sortBy: bookSort);
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(books);
    });

    // Listen for changes in authors collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.authorsStream.listen((_) async {
      // Retrieve all authors from the database.
      allAuthors = await DatabaseRepository.instance.getAllAuthors(
        sortBy: AuthorSort.name,
        sortOrder: SortOrder.ascending,
      );
    });
    return books;
  }

  /// Select sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sort the books according to the selected [BookSort] type.
  Future<void> sort(BookSort value) async {
    // Update [bookSort] to show the selected sort type in the UI.
    bookSort = value;
    // Retrieve the books again in the selected sort type and update the state.
    state = AsyncData(
      await DatabaseRepository.instance.getAllBooks(
        sortBy: bookSort,
        sortOrder: selectedSortOrder,
        genreFilter: genreFilter,
        authorFilter: authorFilter,
        issueStatusFilter: issueStatusFilter,
        minCopiesFilter: minCopiesFilter,
        maxCopiesFilter: maxCopiesFilter,
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }

  void selectGenreFilter(Genre genre) {
    genreFilter = genre;
    ref.notifyListeners();
  }

  void clearGenreFilter() {
    genreFilter = null;
    ref.notifyListeners();
  }

  void selectAuthorFilter(Author author) {
    authorFilter = author;
    ref.notifyListeners();
  }

  void clearAuthorFilter() {
    authorFilter = null;
    ref.notifyListeners();
  }

  void setIssueStatusFilter(bool available) {
    if (available) {
      issueStatusFilter = IssueStatus.available;
    } else {
      issueStatusFilter = IssueStatus.issued;
    }
    ref.notifyListeners();
  }

  void clearIssueStatusFilter() {
    issueStatusFilter = null;
    ref.notifyListeners();
  }

  void setMinCopiesFilter(String value) {
    if (value.isEmpty) return;
    minCopiesFilter = int.parse(value);
    ref.notifyListeners();
  }

  void setMaxCopiesFilter(String value) {
    if (value.isEmpty) return;
    maxCopiesFilter = int.parse(value);
    ref.notifyListeners();
  }

  String? minCopiesFilterValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    if (maxCopiesFilter == null) return null;
    if (int.parse(value) > maxCopiesFilter!) {
      return 'Enter a value less than the maximum';
    } else {
      return null;
    }
  }

  String? totalCopiesFilterMaxValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    if (minCopiesFilter == null) return null;
    if (int.parse(value) < minCopiesFilter!) {
      return 'Enter a value greater than the minimum';
    } else {
      return null;
    }
  }

  void clearTotalCopiesFilter(
    TextEditingController minController,
    TextEditingController maxController,
  ) {
    minCopiesFilter = null;
    maxCopiesFilter = null;
    minController.text = '';
    maxController.text = '';
    ref.notifyListeners();
  }

  void clearAll(
    TextEditingController minController,
    TextEditingController maxController,
  ) {
    genreFilter = null;
    authorFilter = null;
    issueStatusFilter = null;
    minCopiesFilter = null;
    maxCopiesFilter = null;
    minController.text = '';
    maxController.text = '';
    ref.notifyListeners();
  }

  /// Filter the books according to the selected filter values.
  Future<void> applyFilters() async {
    state = AsyncData(
      await DatabaseRepository.instance.getAllBooks(
        sortBy: bookSort,
        sortOrder: selectedSortOrder,
        genreFilter: genreFilter,
        authorFilter: authorFilter,
        issueStatusFilter: issueStatusFilter,
        minCopiesFilter: minCopiesFilter,
        maxCopiesFilter: maxCopiesFilter,
      ),
    );
    // Keep provider alive to preserve the filtered list.
    ref.keepAlive();
  }
}
