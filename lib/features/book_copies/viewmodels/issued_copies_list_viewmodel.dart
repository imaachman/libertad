import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/issued_copy_filters.dart';
import 'package:libertad/data/models/issued_copy_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'issued_copies_list_viewmodel.g.dart';

/// Business logic layer of issued copies list page.
@riverpod
class IssuedCopiesListViewModel extends _$IssuedCopiesListViewModel {
  /// Order in which the sorted list should be displayed.
  SortOrder selectedSortOrder = SortOrder.ascending;

  /// Defines how the issued copies should be sorted.
  IssuedCopySort? issuedCopySort;

  /// Filter the copies by book.
  Book? bookFilter;

  /// Filter the copies by borrower.
  Borrower? borrowerFilter;

  /// Filter the copies by overdue status.
  bool? overdueFilter;

  /// Filter the copies by issue date range.
  DateTime? oldestIssueDateFilter;
  DateTime? newestIssueDateFilter;

  /// Filter the copies by return date range.
  DateTime? oldestReturnDateFilter;
  DateTime? newestReturnDateFilter;

  /// Used to show as options in the book filter.
  List<Book> allBooks = [];

  /// Used to show as options in the borrower filter.
  List<Borrower> allBorrowers = [];

  @override
  Future<List<BookCopy>> build() async {
    List<BookCopy> issuedCopies = [];
    // Listen for changes in book copies collection and update the state with
    // the latest data. The stream fires a snapshot immediately, so we don't
    // need to initialize data seperately. This listener handles the
    // initialization as well.
    DatabaseRepository.instance.bookCopiesStream.listen((_) async {
      // Retrieve issued copies from the database.
      issuedCopies = await DatabaseRepository.instance.getIssuedCopies(
        sortBy: issuedCopySort,
        sortOrder: selectedSortOrder,
        filters: IssuedCopyFilters(
          bookFilter: bookFilter,
          borrowerFilter: borrowerFilter,
          overdueFilter: overdueFilter,
          oldestIssueDateFilter: oldestIssueDateFilter,
          newestIssueDateFilter: newestIssueDateFilter,
          oldestReturnDateFilter: oldestReturnDateFilter,
          newestReturnDateFilter: newestReturnDateFilter,
        ),
      );
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(issuedCopies);
    });

    // Listen for changes in books collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.booksStream.listen((_) async {
      // Retrieve all authors from the database.
      allBooks = await DatabaseRepository.instance.getBooks(
        sortBy: BookSort.title,
        sortOrder: SortOrder.ascending,
      );
    });

    // Listen for changes in borrowers collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.borrowersStream.listen((_) async {
      // Retrieve all authors from the database.
      allBorrowers = await DatabaseRepository.instance.getBorrowers(
        sortBy: BorrowerSort.name,
        sortOrder: SortOrder.ascending,
      );
      ref.notifyListeners();
    });
    return issuedCopies;
  }

  /// Selects sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sorts the copies according to the selected [IssuedCopySort] type.
  Future<void> sort(IssuedCopySort value) async {
    // Update [issuedCopySort] to show the selected sort type in the UI.
    issuedCopySort = value;
    // Retrieve the copies again in the selected sort type and update the state.
    state = AsyncData(
      await DatabaseRepository.instance.getIssuedCopies(
        sortBy: issuedCopySort,
        sortOrder: selectedSortOrder,
        filters: IssuedCopyFilters(
          bookFilter: bookFilter,
          borrowerFilter: borrowerFilter,
          overdueFilter: overdueFilter,
          oldestIssueDateFilter: oldestIssueDateFilter,
          newestIssueDateFilter: newestIssueDateFilter,
          oldestReturnDateFilter: oldestReturnDateFilter,
          newestReturnDateFilter: newestReturnDateFilter,
        ),
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }

  /// Selects book filter.
  void selectBookFilter(Book book) {
    bookFilter = book;
    ref.notifyListeners();
  }

  /// Clears book filter.
  void clearBookFilter() {
    bookFilter = null;
    ref.notifyListeners();
  }

  /// Selects borrower filter.
  void selectBorrowerFilter(Borrower borrower) {
    borrowerFilter = borrower;
    ref.notifyListeners();
  }

  /// Clears borrower filter.
  void clearBorrowerFilter() {
    borrowerFilter = null;
    ref.notifyListeners();
  }

  /// Sets overdue filter.
  void setOverdueFilter(bool overdue) {
    overdueFilter = overdue;
    ref.notifyListeners();
  }

  /// Clears overdue filter.
  void clearOverdueFilter() {
    overdueFilter = null;
    ref.notifyListeners();
  }

  /// Selects oldest issue date filter.
  void selectOldestIssueDateFilter(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: oldestIssueDateFilter,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update the filter.
    if (selectedDate != null) {
      oldestIssueDateFilter = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Selects newest issue date filter.
  void selectNewestIssueDateFilter(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: newestIssueDateFilter,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update the filter.
    if (selectedDate != null) {
      newestIssueDateFilter = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Clears issue date filter.
  void clearIssueDateFilter() {
    oldestIssueDateFilter = null;
    newestIssueDateFilter = null;
    ref.notifyListeners();
  }

  /// Selects oldest return date filter.
  void selectOldestReturnDateFilter(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: oldestReturnDateFilter,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(Duration(days: 180)),
    );

    // If a date is selected, update the filter.
    if (selectedDate != null) {
      oldestReturnDateFilter = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Selects newest return date filter.
  void selectNewestReturnDateFilter(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: newestReturnDateFilter,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(Duration(days: 180)),
    );

    // If a date is selected, update the filter.
    if (selectedDate != null) {
      newestReturnDateFilter = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Clears return date filter.
  void clearReturnDateFilter() {
    oldestReturnDateFilter = null;
    newestReturnDateFilter = null;
    ref.notifyListeners();
  }

  /// Clears all filters.
  void clearAll() {
    bookFilter = null;
    borrowerFilter = null;
    overdueFilter = null;
    oldestIssueDateFilter = null;
    newestIssueDateFilter = null;
    oldestReturnDateFilter = null;
    newestReturnDateFilter = null;
    ref.notifyListeners();
  }

  /// Filters the issued copies according to the selected filter values.
  Future<void> applyFilters(BuildContext context) async {
    state = AsyncData(
      await DatabaseRepository.instance.getIssuedCopies(
        sortBy: issuedCopySort,
        sortOrder: selectedSortOrder,
        filters: IssuedCopyFilters(
          bookFilter: bookFilter,
          borrowerFilter: borrowerFilter,
          overdueFilter: overdueFilter,
          oldestIssueDateFilter: oldestIssueDateFilter,
          newestIssueDateFilter: newestIssueDateFilter,
          oldestReturnDateFilter: oldestReturnDateFilter,
          newestReturnDateFilter: newestReturnDateFilter,
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
