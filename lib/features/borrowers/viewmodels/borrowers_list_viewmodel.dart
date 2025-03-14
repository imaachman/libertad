import 'package:flutter/material.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'borrowers_list_viewmodel.g.dart';

@riverpod
class BorrowersListViewModel extends _$BorrowersListViewModel {
  SortOrder selectedSortOrder = SortOrder.ascending;
  BorrowerSort? borrowerSort;

  bool? activeFilter;
  bool? defaulterFilter;
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
      borrowers = await DatabaseRepository.instance.getAllBorrowers(
        sortBy: borrowerSort,
        sortOrder: selectedSortOrder,
        activeFilter: activeFilter,
        defaulterFilter: defaulterFilter,
        oldestMembershipStartDateFilter: oldestMembershipStartDateFilter,
        newestMembershipStartDateFilter: newestMembershipStartDateFilter,
      );
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(borrowers);
    });
    return borrowers;
  }

  /// Select sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sort the books according to the selected [BorrowerSort] type.
  Future<void> sort(BorrowerSort sortBy) async {
    // Update [borrowerSort] to show the selected sort type in the UI.
    borrowerSort = sortBy;
    // Retrieve the borrowers again in the selected sort type and update the
    // state.
    state = AsyncData(
      await DatabaseRepository.instance.getAllBorrowers(
        sortBy: borrowerSort,
        sortOrder: selectedSortOrder,
        activeFilter: activeFilter,
        defaulterFilter: defaulterFilter,
        oldestMembershipStartDateFilter: oldestMembershipStartDateFilter,
        newestMembershipStartDateFilter: newestMembershipStartDateFilter,
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }

  void setActiveFilter(bool active) {
    activeFilter = active;
    ref.notifyListeners();
  }

  void clearActiveFilter() {
    activeFilter = null;
    ref.notifyListeners();
  }

  void setDefaulterFilter(bool defaulter) {
    defaulterFilter = defaulter;
    ref.notifyListeners();
  }

  void clearDefaulterFilter() {
    defaulterFilter = null;
    ref.notifyListeners();
  }

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

  void clearIssueDateFilter() {
    oldestMembershipStartDateFilter = null;
    newestMembershipStartDateFilter = null;
    ref.notifyListeners();
  }

  void clearAll() {
    activeFilter = null;
    defaulterFilter = null;
    oldestMembershipStartDateFilter = null;
    newestMembershipStartDateFilter = null;
    ref.notifyListeners();
  }

  /// Filter the borrowers according to the selected filter values.
  Future<void> applyFilters(BuildContext context) async {
    state = AsyncData(
      await DatabaseRepository.instance.getAllBorrowers(
        sortBy: borrowerSort,
        sortOrder: selectedSortOrder,
        activeFilter: activeFilter,
        defaulterFilter: defaulterFilter,
        oldestMembershipStartDateFilter: oldestMembershipStartDateFilter,
        newestMembershipStartDateFilter: newestMembershipStartDateFilter,
      ),
    );
    // Keep provider alive to preserve the filtered list.
    ref.keepAlive();

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
