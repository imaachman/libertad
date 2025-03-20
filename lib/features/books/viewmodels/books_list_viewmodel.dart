import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_filters.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/data/models/issue_status.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'books_list_viewmodel.g.dart';

/// Business logic layer for books list page.
@riverpod
class BooksListViewModel extends _$BooksListViewModel {
  /// Order in which the sorted list should be displayed.
  SortOrder selectedSortOrder = SortOrder.ascending;

  /// Defines how the books should be sorted.
  BookSort? bookSort;

  /// Filter the books by genre.
  Genre? genreFilter;

  /// Filter the books by author.
  Author? authorFilter;

  /// Filter the books by release date range.
  DateTime? oldestReleaseDateFilter;
  DateTime? newestReleaseDateFilter;

  /// Filter the books by availability.
  IssueStatus? issueStatusFilter;

  /// Filter the books by total copies range.
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
      books = await DatabaseRepository.instance.getBooks(
        sortBy: bookSort,
        sortOrder: selectedSortOrder,
        filters: BookFilters(
          genreFilter: genreFilter,
          authorFilter: authorFilter,
          oldestReleaseDateFilter: oldestReleaseDateFilter,
          newestReleaseDateFilter: newestReleaseDateFilter,
          issueStatusFilter: issueStatusFilter,
          minCopiesFilter: minCopiesFilter,
          maxCopiesFilter: maxCopiesFilter,
        ),
      );
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(books);
    });

    // Listen for changes in book copies collection to actively update the
    // number of issued copies in the book list tile.
    //
    // Cases include:
    // 1. Book issued
    // 2. Book returned
    // 3. Borrower deleted, in turn un-issuing the borrowed copies
    DatabaseRepository.instance.bookCopiesStream.listen((_) async {
      // Retrieve all books from the database.
      books = await DatabaseRepository.instance.getBooks(
        sortBy: bookSort,
        sortOrder: selectedSortOrder,
        filters: BookFilters(
          genreFilter: genreFilter,
          authorFilter: authorFilter,
          oldestReleaseDateFilter: oldestReleaseDateFilter,
          newestReleaseDateFilter: newestReleaseDateFilter,
          issueStatusFilter: issueStatusFilter,
          minCopiesFilter: minCopiesFilter,
          maxCopiesFilter: maxCopiesFilter,
        ),
      );
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(books);
    });

    // Listen for changes in authors collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.authorsStream.listen((_) async {
      // Retrieve all authors from the database.
      allAuthors = await DatabaseRepository.instance.getAuthors(
        sortBy: AuthorSort.name,
        sortOrder: SortOrder.ascending,
      );
      ref.notifyListeners();
    });
    return books;
  }

  /// Selects sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sorts the books according to the selected [BookSort] type.
  Future<void> sort(BookSort value) async {
    // Update [bookSort] to show the selected sort type in the UI.
    bookSort = value;
    // Retrieve the books again in the selected sort type and update the state.
    state = AsyncData(
      await DatabaseRepository.instance.getBooks(
        sortBy: bookSort,
        sortOrder: selectedSortOrder,
        filters: BookFilters(
          genreFilter: genreFilter,
          authorFilter: authorFilter,
          oldestReleaseDateFilter: oldestReleaseDateFilter,
          newestReleaseDateFilter: newestReleaseDateFilter,
          issueStatusFilter: issueStatusFilter,
          minCopiesFilter: minCopiesFilter,
          maxCopiesFilter: maxCopiesFilter,
        ),
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }

  /// Selects genre filter.
  void selectGenreFilter(Genre genre) {
    genreFilter = genre;
    ref.notifyListeners();
  }

  /// Clears genre filter.
  void clearGenreFilter() {
    genreFilter = null;
    ref.notifyListeners();
  }

  /// Selects author fitler.
  void selectAuthorFilter(Author author) {
    authorFilter = author;
    ref.notifyListeners();
  }

  /// Clears author filter.
  void clearAuthorFilter() {
    authorFilter = null;
    ref.notifyListeners();
  }

  /// Selects oldest release date filter.
  void selectOldestReleaseDateFilter(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: oldestReleaseDateFilter,
      firstDate: DateTime(1000),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update the filter.
    if (selectedDate != null) {
      oldestReleaseDateFilter = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Selects newest release date filter.
  void selectNewestReleaseDateFilter(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: newestReleaseDateFilter,
      firstDate: DateTime(1000),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update the filter.
    if (selectedDate != null) {
      newestReleaseDateFilter = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Clears release date filter.
  void clearReleaseDateFilter() {
    oldestReleaseDateFilter = null;
    newestReleaseDateFilter = null;
    ref.notifyListeners();
  }

  /// Sets availability filter.
  void setIssueStatusFilter(bool available) {
    if (available) {
      issueStatusFilter = IssueStatus.available;
    } else {
      issueStatusFilter = IssueStatus.issued;
    }
    ref.notifyListeners();
  }

  /// Clears availabilty filter.
  void clearIssueStatusFilter() {
    issueStatusFilter = null;
    ref.notifyListeners();
  }

  /// Sets minimum total copies filter.
  void setMinCopiesFilter(String value) {
    if (value.isEmpty) return;
    minCopiesFilter = int.parse(value);
    ref.notifyListeners();
  }

  /// Sets maximum total copies filter.
  void setMaxCopiesFilter(String value) {
    if (value.isEmpty) return;
    maxCopiesFilter = int.parse(value);
    ref.notifyListeners();
  }

  /// Validates min total copies field.
  /// Returned string is displayed to the user as feedback.
  String? minCopiesFilterValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    if (maxCopiesFilter == null) return null;
    if (int.parse(value) > maxCopiesFilter!) {
      return 'Enter a value less than the maximum';
    } else {
      return null;
    }
  }

  /// Validates max total copies field.
  /// Returned string is displayed to the user as feedback.
  String? maxCopiesFilterValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    if (minCopiesFilter == null) return null;
    if (int.parse(value) < minCopiesFilter!) {
      return 'Enter a value greater than the minimum';
    } else {
      return null;
    }
  }

  /// Clears total copies filter.
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

  /// Clears all filters.
  void clearAll(
    TextEditingController minController,
    TextEditingController maxController,
  ) {
    genreFilter = null;
    authorFilter = null;
    issueStatusFilter = null;
    oldestReleaseDateFilter = null;
    newestReleaseDateFilter = null;
    minCopiesFilter = null;
    maxCopiesFilter = null;
    minController.text = '';
    maxController.text = '';
    ref.notifyListeners();
  }

  /// Filters the books according to the selected filter values.
  Future<void> applyFilters(BuildContext context) async {
    state = AsyncData(
      await DatabaseRepository.instance.getBooks(
        sortBy: bookSort,
        sortOrder: selectedSortOrder,
        filters: BookFilters(
          genreFilter: genreFilter,
          authorFilter: authorFilter,
          oldestReleaseDateFilter: oldestReleaseDateFilter,
          newestReleaseDateFilter: newestReleaseDateFilter,
          issueStatusFilter: issueStatusFilter,
          minCopiesFilter: minCopiesFilter,
          maxCopiesFilter: maxCopiesFilter,
        ),
      ),
    );

    // Keep provider alive to preserve the filtered list.
    ref.keepAlive();

    // Navigate back.
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
