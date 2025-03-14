import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/issued_copy_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'issued_copies_list_viewmodel.g.dart';

@riverpod
class IssuedCopiesListViewModel extends _$IssuedCopiesListViewModel {
  SortOrder selectedSortOrder = SortOrder.ascending;
  IssuedCopySort? issuedCopySort;

  Book? bookFilter;
  Borrower? borrowerFilter;
  bool? overdueFilter;
  DateTime? oldestIssueDateFilter;
  DateTime? newestIssueDateFilter;
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
        bookFilter: bookFilter,
        borrowerFilter: borrowerFilter,
        overdueFilter: overdueFilter,
        oldestIssueDateFilter: oldestIssueDateFilter,
        newestIssueDateFilter: newestIssueDateFilter,
        oldestReturnDateFilter: oldestReturnDateFilter,
        newestReturnDateFilter: newestReturnDateFilter,
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
      allBooks = await DatabaseRepository.instance.getAllBooks(
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
      allBorrowers = await DatabaseRepository.instance.getAllBorrowers(
        sortBy: BorrowerSort.name,
        sortOrder: SortOrder.ascending,
      );
    });
    return issuedCopies;
  }

  /// Select sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sort the copies according to the selected [IssuedCopySort] type.
  Future<void> sort(IssuedCopySort sortBy) async {
    // Update [issuedCopySort] to show the selected sort type in the UI.
    issuedCopySort = sortBy;
    // Retrieve the copies again in the selected sort type and update the state.
    state = AsyncData(
      await DatabaseRepository.instance.getIssuedCopies(
        sortBy: issuedCopySort,
        sortOrder: selectedSortOrder,
        bookFilter: bookFilter,
        borrowerFilter: borrowerFilter,
        overdueFilter: overdueFilter,
        oldestIssueDateFilter: oldestIssueDateFilter,
        newestIssueDateFilter: newestIssueDateFilter,
        oldestReturnDateFilter: oldestReturnDateFilter,
        newestReturnDateFilter: newestReturnDateFilter,
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }

  void selectBookFilter(Book book) {
    bookFilter = book;
    ref.notifyListeners();
  }

  void clearBookFilter() {
    bookFilter = null;
    ref.notifyListeners();
  }

  void selectBorrowerFilter(Borrower borrower) {
    borrowerFilter = borrower;
    ref.notifyListeners();
  }

  void clearBorrowerFilter() {
    borrowerFilter = null;
    ref.notifyListeners();
  }

  void setOverdueFilter(bool overdue) {
    overdueFilter = overdue;
    ref.notifyListeners();
  }

  void clearOverdueFilter() {
    overdueFilter = null;
    ref.notifyListeners();
  }

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

  void clearIssueDateFilter() {
    oldestIssueDateFilter = null;
    newestIssueDateFilter = null;
    ref.notifyListeners();
  }

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

  void clearReturnDateFilter() {
    oldestReturnDateFilter = null;
    newestReturnDateFilter = null;
    ref.notifyListeners();
  }

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

  /// Filter the issued copies according to the selected filter values.
  Future<void> applyFilters(BuildContext context) async {
    state = AsyncData(
      await DatabaseRepository.instance.getIssuedCopies(
        sortBy: issuedCopySort,
        sortOrder: selectedSortOrder,
        bookFilter: bookFilter,
        borrowerFilter: borrowerFilter,
        overdueFilter: overdueFilter,
        oldestIssueDateFilter: oldestIssueDateFilter,
        newestIssueDateFilter: newestIssueDateFilter,
        oldestReturnDateFilter: oldestReturnDateFilter,
        newestReturnDateFilter: newestReturnDateFilter,
      ),
    );
    // Keep provider alive to preserve the filtered list.
    ref.keepAlive();

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
