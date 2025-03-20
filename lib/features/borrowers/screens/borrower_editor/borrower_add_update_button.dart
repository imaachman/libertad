import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/viewmodels/borrower_editor_viewmodel.dart';

/// Button that adds a new borrower to the database, or updates an existing one.
class BorrowerAddUpdateButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final Borrower? borrower;

  const BorrowerAddUpdateButton(
      {super.key, required this.formKey, this.borrower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BorrowerEditorViewModel model =
        ref.watch(borrowerEditorViewModelProvider(borrower: borrower).notifier);

    return TextButton(
      onPressed: () {
        if (borrower == null) {
          model.addBorrower(context, formKey);
        } else {
          model.updateBorrower(context, formKey, borrower!);
        }
      },
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).primaryColor,
        ),
      ),
      child: SizedBox(
        height: 48,
        child: Center(
          child: Text(
            borrower == null ? 'Add Borrower' : 'Update Borrower',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
