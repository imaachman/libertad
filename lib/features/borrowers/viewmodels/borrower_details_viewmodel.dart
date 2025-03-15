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

@riverpod
class BorrowerDetailsViewModel extends _$BorrowerDetailsViewModel {
  @override
  Borrower build(Borrower borrower) {
    DatabaseRepository.instance
        .borrowerStream(borrower.id)
        .listen((_) => ref.notifyListeners());
    return borrower;
  }

  Future<void> showDeletionDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => BorrowerDeletionDialog(
        borrower: borrower,
        onDelete: () => deleteBorrower(context),
      ),
    );
  }

  Future<bool> deleteBorrower(BuildContext context) async {
    final bool borrowerDeleted =
        await DatabaseRepository.instance.deleteBorrower(borrower);
    if (!borrowerDeleted) return false;

    if (borrower.profilePicture.isNotEmpty) {
      // Delete profile picture file only if the borrower was deleted
      // succesfully.
      await FilesRepository.instance.deleteFile(borrower.profilePicture);
    }

    if (context.mounted) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name == Routes.home);
    }

    return borrowerDeleted;
  }

  Future<void> showBorrowerEditor(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BorrowerEditor(borrower: borrower),
      isScrollControlled: true,
      showDragHandle: true,
    );
  }

  /// Shows dialog to pay the fine.
  Future<void> showFineDialog(BuildContext context, Borrower borrower) =>
      showDialog(
          context: context,
          builder: (context) => FineDialog(borrower: borrower));

  Future<void> acceptFine(BuildContext context) async {
    // Update borrower's defaulter status and reset fine amount.
    borrower
      ..isDefaulter = false
      ..fineDue = 0;

    // Update borrower's defaulter and fine status in the database.
    await DatabaseRepository.instance.acceptFine(borrower);

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
