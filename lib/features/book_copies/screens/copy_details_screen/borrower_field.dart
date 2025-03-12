import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/features/book_copies/viewmodels/copy_details_viewmodel.dart';

class BorrowerField extends ConsumerWidget {
  final BookCopy copy;

  const BorrowerField({super.key, required this.copy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the [CopyDetailsViewModel] provider to update the UI with the
    // selected borrower.
    ref.watch(copyDetailsViewModelProvider(copy));
    // Access [CopyDetailsViewModel] to fetch and select a borrower.
    final CopyDetailsViewModel model =
        ref.watch(copyDetailsViewModelProvider(copy).notifier);
    // Check if a borrower is selected.
    final bool borrowerNotSelected = !model.isBorrowerSelected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Borrower',
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(letterSpacing: 1.5),
        ),
        SizedBox(height: 4),
        InkWell(
          onTap: () => model.selectBorrower(context),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: borrowerNotSelected
                  ? Border.all(color: Theme.of(context).colorScheme.error)
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // width: double.infinity,
            height: 56,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  size: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                SizedBox(width: 16),
                Text(
                  model.borrower?.name ?? 'Select borrower',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        if (borrowerNotSelected) ...[
          SizedBox(height: 4),
          Text(
            'Please select the borrower',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ]
      ],
    );
  }
}
