import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/features/book_copies/viewmodels/copy_details_viewmodel.dart';

import 'borrower_field.dart';
import 'issue_date_field.dart';
import 'return_date_field.dart';

class EditDialog extends ConsumerWidget {
  final BookCopy copy;

  const EditDialog({super.key, required this.copy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(copyDetailsViewModelProvider(copy));
    final CopyDetailsViewModel model =
        ref.watch(copyDetailsViewModelProvider(copy).notifier);

    return Dialog(
      shape: RoundedRectangleBorder(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text(
                  'Edit Issuance Details',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(height: 0),
          SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: IssueDateField(copy: copy),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ReturnDateField(copy: copy),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: BorrowerField(copy: copy),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () => model.saveEdits(context),
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
                  'Save Edits',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
