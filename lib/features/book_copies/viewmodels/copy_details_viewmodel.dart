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
    issueDate = copy.issueDate;
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
      firstDate: DateTime.now().add(Duration(days: 7)),
      lastDate: DateTime.now().add(Duration(days: 180)),
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
    borrower = await showSearch<Borrower?>(
      context: context,
      delegate: BorrowersSearchDelegate(),
    );
    if (borrower == null) return;
    // Mark borrower as selected.
    isBorrowerSelected = true;
    ref.notifyListeners();
  }

  Future<void> issueBook() async {
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
      ..issueDate = DateTime.now()
      ..returnDate = returnDate!
      ..status = IssueStatus.issued;

    // Update database with the issued copy.
    await DatabaseRepository.instance.issueCopy(copy, borrower!);
  }

  Future<void> returnBook() async {
    // Mark the copy as returned.
    // Return date is the current date.
    copy
      ..returnDate = DateTime.now()
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
  }

  // Future<void> showDeletionDialog(BuildContext context) async {
  //   await showAdaptiveDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: RichText(
  //         text: TextSpan(
  //           style: Theme.of(context).textTheme.bodyLarge,
  //           children: [
  //             TextSpan(text: 'Are you sure you want to delete borrower '),
  //             TextSpan(
  //               text: borrower.name,
  //               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
  //                     color: Theme.of(context).colorScheme.error,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //             ),
  //             TextSpan(text: '?'),
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             await deleteBorrower(borrower);
  //             if (!context.mounted) return;
  //             Navigator.of(context)
  //                 .popUntil((route) => route.settings.name == '/');
  //           },
  //           child: Text('Confirm'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<bool> deleteBorrower(Borrower borrower) async {
  //   final bool borrowerDeleted =
  //       await DatabaseRepository.instance.deleteBorrower(borrower);
  //   if (!borrowerDeleted) return false;
  //   if (borrower.profilePicture.isNotEmpty) {
  //     // Delete profile picture file only if the borrower was deleted
  //     // succesfully.
  //     await FilesRepository.instance.deleteFile(borrower.profilePicture);
  //   }
  //   return borrowerDeleted;
  // }

  // Future<void> showBorrowerEditor(BuildContext context) async {
  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (context) => BorrowerEditor(borrower: borrower),
  //     isScrollControlled: true,
  //     showDragHandle: true,
  //   );
  // }
}
