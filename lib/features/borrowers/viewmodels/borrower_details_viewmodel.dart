import 'package:flutter/material.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/borrowers/screens/borrower_details_screen/borrower_deletion_dialog.dart';
import 'package:libertad/features/borrowers/screens/borrower_details_screen/fine_dialog.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/borrower_editor.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'borrower_details_viewmodel.g.dart';

/// Business logic layer for borrower details page.
@riverpod
class BorrowerDetailsViewModel extends _$BorrowerDetailsViewModel {
  @override
  Borrower build(Borrower borrower) {
    // Listen for changes to this particular borrower object and update the
    // state with the latest data.
    DatabaseRepository.instance
        .borrowerStream(borrower.id)
        .listen((_) => ref.notifyListeners());
    return borrower;
  }

  /// Shows borrower deletion dialog.
  Future<void> showDeletionDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => BorrowerDeletionDialog(
        borrower: borrower,
        onDelete: () => deleteBorrower(context),
      ),
    );
  }

  /// Deletes the borrower from database and also its profile picture from the
  /// app directory.
  Future<bool> deleteBorrower(BuildContext context) async {
    // Delete the borrower from database.
    final bool borrowerDeleted =
        await DatabaseRepository.instance.deleteBorrower(borrower);
    // If borrower wasn't successfully deleted, return false.
    if (!borrowerDeleted) return false;
    // If borrower had a profile picture.
    if (borrower.profilePicture.isNotEmpty) {
      // Delete profile picture file only if the borrower was deleted
      // successfully.
      await FilesRepository.instance.deleteFile(borrower.profilePicture);
    }
    // Navigate back to the home page.
    if (context.mounted) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name == Routes.home);
    }
    // Return deletion status.
    return borrowerDeleted;
  }

  /// Shows borrower editor.
  Future<void> showBorrowerEditor(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BorrowerEditor(borrower: borrower),
      isScrollControlled: true,
      showDragHandle: true,
    );
  }

  /// Shows dialog to accept the fine.
  Future<void> showFineDialog(BuildContext context, Borrower borrower) =>
      showDialog(
          context: context,
          builder: (context) => FineDialog(borrower: borrower));

  /// Accepts fine and removes the borrower's defaulter status.
  Future<void> acceptFine(BuildContext context) async {
    // Update borrower's defaulter status and reset fine amount.
    borrower
      ..isDefaulter = false
      ..fineDue = 0;

    // Update borrower's defaulter and fine status in the database.
    await DatabaseRepository.instance.acceptFine(borrower);

    // Navigate back.
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
