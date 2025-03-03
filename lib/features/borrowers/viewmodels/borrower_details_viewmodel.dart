import 'package:flutter/material.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/borrower_editor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'borrower_details_viewmodel.g.dart';

@riverpod
class BorrowerDetailsViewModel extends _$BorrowerDetailsViewModel {
  @override
  Borrower build(Borrower borrower) {
    DatabaseRepository.instance
        .borrowerStream(borrower.id)
        .listen((_) => ref.notifyListeners());
    // DatabaseRepository.instance.bookCopiesStream
    //     .listen((_) => ref.notifyListeners());
    return borrower;
  }

  Future<void> showDeletionDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(text: 'Are you sure you want to delete borrower '),
              TextSpan(
                text: borrower.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(text: '?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await deleteBorrower(borrower);
              if (!context.mounted) return;
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/');
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<bool> deleteBorrower(Borrower borrower) async {
    final bool borrowerDeleted =
        await DatabaseRepository.instance.deleteBorrower(borrower);
    if (!borrowerDeleted) return false;
    if (borrower.profilePicture.isNotEmpty) {
      // Delete profile picture file only if the borrower was deleted
      // succesfully.
      await FilesRepository.instance.deleteFile(borrower.profilePicture);
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
}
