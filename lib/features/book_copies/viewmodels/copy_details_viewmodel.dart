import 'package:flutter/material.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/issue_status.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/borrowers_search_delegate.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/edit_dialog.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/issue_dialog.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/return_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'copy_details_viewmodel.g.dart';

@riverpod
class CopyDetailsViewModel extends _$CopyDetailsViewModel {
  /// Issue date of the copy.
  DateTime? issueDate;

  /// Return date of the copy.
  DateTime? returnDate;

  /// Borrower of the book.
  Borrower? borrower;

  /// Whether the return date is selected or not.
  bool isReturnDateSelected = true;

  /// Whether a borrower is selected or not.
  bool isBorrowerSelected = true;

  @override
  BookCopy build(BookCopy copy) {
    issueDate = copy.issueDate ?? DateTime.now();
    returnDate = copy.returnDate;
    borrower = copy.currentBorrower.value;
    if (returnDate != null) isReturnDateSelected = true;
    if (borrower != null) isBorrowerSelected = true;
    // DatabaseRepository.instance
    //     .borrowerStream(borrower.id)
    //     .listen((_) => ref.notifyListeners());
    DatabaseRepository.instance.bookCopiesStream
        .listen((_) => ref.notifyListeners());
    return copy;
  }

  /// Shows dialog to issue book.
  Future<void> showIssueDialog(BuildContext context, BookCopy copy) =>
      showDialog(
          context: context, builder: (context) => IssueDialog(copy: copy));

  /// Shows dialog to return book.
  Future<void> showReturnDialog(BuildContext context, BookCopy copy) =>
      showDialog(
          context: context, builder: (context) => ReturnDialog(copy: copy));

  /// Shows dialog to edit issuance details.
  Future<void> showEditDialog(BuildContext context, BookCopy copy) =>
      showDialog(
          context: context, builder: (context) => EditDialog(copy: copy));

  /// Opens date picker and selects the issue date of the copy.
  Future<void> selectIssueDate(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: issueDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update the issue date.
    if (selectedDate != null) {
      issueDate = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Opens date picker and selects the return date of the copy.
  Future<void> selectReturnDate(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: returnDate,
      firstDate: issueDate!.add(Duration(days: 7)),
      lastDate: issueDate!.add(Duration(days: 180)),
    );

    // If a date is selected, update the issue date.
    if (selectedDate != null) {
      returnDate = selectedDate;
      // Mark return date as selected.
      isReturnDateSelected = true;
      ref.notifyListeners();
    }
  }

  /// Opens borrower search view to select a borrower for the copy.
  /// Also marks the borrower as selected to validate the state of
  /// [BorrowerField].
  Future<void> selectBorrower(BuildContext context) async {
    // Show borrower search view to select a borrower.
    final selectedBorrower = await showSearch<Borrower?>(
      context: context,
      delegate: BorrowersSearchDelegate(),
    );
    // Don't update [borrower] if no borrower is selected.
    if (selectedBorrower == null) return;
    // Update [borrower].
    borrower = selectedBorrower;
    // Mark borrower as selected.
    isBorrowerSelected = true;
    ref.notifyListeners();
  }

  Future<void> issueBook(BuildContext context) async {
    // Check if the return date is selected.
    if (returnDate == null) {
      // Mark return date as unselected to show invalid state.
      isReturnDateSelected = false;
      ref.notifyListeners();
    }

    // Check if the borrower is selected.
    if (borrower == null) {
      // Mark borrower as unselected to show invalid state.
      isBorrowerSelected = false;
      ref.notifyListeners();
    }

    // If any of the inputs are invalid, do not issue the book.
    if (!isReturnDateSelected || !isBorrowerSelected) return;

    // Issue the copy to the borrower.
    // Issue date is the current date.
    copy
      ..issueDate = issueDate!
      ..returnDate = returnDate!
      ..status = IssueStatus.issued;

    // Update database with the issued copy.
    await DatabaseRepository.instance.issueCopy(copy, borrower!);

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> returnBook(BuildContext context) async {
    // Mark the copy as returned.
    // Return date is the current date.
    copy
      ..issueDate = null
      ..returnDate = null
      ..status = IssueStatus.available;

    // If the book was returned after its return date, mark the borrower as
    // defaulter and add a fine of $2 for each day the book wasn't returned.
    if (copy.returnDatePassed) {
      borrower!
        ..isDefaulter = true
        ..fineDue = copy.overdueBy() * 2.0;
    }

    // Mark the copy as returned in the database.
    await DatabaseRepository.instance.returnCopy(copy, borrower!);

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> saveEdits(BuildContext context) async {
    // Edit issuance details of the copy.
    copy
      ..issueDate = issueDate
      ..returnDate = returnDate;

    // Update database with the new details.
    await DatabaseRepository.instance.issueCopy(copy, borrower!);

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
