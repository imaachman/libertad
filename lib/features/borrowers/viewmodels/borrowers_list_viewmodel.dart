import 'package:flutter/material.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_filters.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'borrowers_list_viewmodel.g.dart';

/// Business logic layer for borrowers list page.
@riverpod
class BorrowersListViewModel extends _$BorrowersListViewModel {
  /// Order in which the sorted list should be displayed.
  SortOrder selectedSortOrder = SortOrder.ascending;

  /// Defines how the borrowers should be sorted.
  BorrowerSort? borrowerSort;

  /// Filter the borrowers by active status.
  bool? activeFilter;

  /// Filter the borrowers by defaulter status.
  bool? defaulterFilter;

  /// Filter the borrowers by membership start date range.
  DateTime? oldestMembershipStartDateFilter;
  DateTime? newestMembershipStartDateFilter;

  @override
  Future<List<Borrower>> build() async {
    List<Borrower> borrowers = [];
    // Listen for changes in borrowers collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.borrowersStream.listen((_) async {
      // Retrieve all borrowers from the database.
      borrowers = await DatabaseRepository.instance.getBorrowers(
        sortBy: borrowerSort,
        sortOrder: selectedSortOrder,
        filters: BorrowerFilters(
          activeFilter: activeFilter,
          defaulterFilter: defaulterFilter,
          oldestMembershipStartDateFilter: oldestMembershipStartDateFilter,
          newestMembershipStartDateFilter: newestMembershipStartDateFilter,
        ),
      );
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(borrowers);
    });
    return borrowers;
  }

  /// Selects sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sorts the books according to the selected [BorrowerSort] type.
  Future<void> sort(BorrowerSort value) async {
    // Update [borrowerSort] to show the selected sort type in the UI.
    borrowerSort = value;
    // Retrieve the borrowers again in the selected sort type and update the
    // state.
    state = AsyncData(
      await DatabaseRepository.instance.getBorrowers(
        sortBy: borrowerSort,
        sortOrder: selectedSortOrder,
        filters: BorrowerFilters(
          activeFilter: activeFilter,
          defaulterFilter: defaulterFilter,
          oldestMembershipStartDateFilter: oldestMembershipStartDateFilter,
          newestMembershipStartDateFilter: newestMembershipStartDateFilter,
        ),
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }

  /// Sets active status filter.
  void setActiveFilter(bool active) {
    activeFilter = active;
    ref.notifyListeners();
  }

  /// Clears active status filter.
  void clearActiveFilter() {
    activeFilter = null;
    ref.notifyListeners();
  }

  /// Sets defaulter status filter.
  void setDefaulterFilter(bool defaulter) {
    defaulterFilter = defaulter;
    ref.notifyListeners();
  }

  /// Clears defaulter status filter.
  void clearDefaulterFilter() {
    defaulterFilter = null;
    ref.notifyListeners();
  }

  /// Selects oldest membership start date filter.
  void selectOldestMembershipStartDateFilter(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: oldestMembershipStartDateFilter,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update the filter.
    if (selectedDate != null) {
      oldestMembershipStartDateFilter = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Selects newest membership start date filter.
  void selectNewestMembershipStartDateFilter(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: newestMembershipStartDateFilter,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update the filter.
    if (selectedDate != null) {
      newestMembershipStartDateFilter = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Clears membership start date filter.
  void clearIssueDateFilter() {
    oldestMembershipStartDateFilter = null;
    newestMembershipStartDateFilter = null;
    ref.notifyListeners();
  }

  /// Clears all filters.
  void clearAll() {
    activeFilter = null;
    defaulterFilter = null;
    oldestMembershipStartDateFilter = null;
    newestMembershipStartDateFilter = null;
    ref.notifyListeners();
  }

  /// Filters the borrowers according to the selected filter values.
  Future<void> applyFilters(BuildContext context) async {
    state = AsyncData(
      await DatabaseRepository.instance.getBorrowers(
        sortBy: borrowerSort,
        sortOrder: selectedSortOrder,
        filters: BorrowerFilters(
          activeFilter: activeFilter,
          defaulterFilter: defaulterFilter,
          oldestMembershipStartDateFilter: oldestMembershipStartDateFilter,
          newestMembershipStartDateFilter: newestMembershipStartDateFilter,
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
