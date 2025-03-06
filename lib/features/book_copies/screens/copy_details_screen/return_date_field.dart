import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/features/book_copies/viewmodels/copy_details_viewmodel.dart';

class ReturnDateField extends ConsumerWidget {
  final BookCopy copy;

  const ReturnDateField({super.key, required this.copy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the [CopyDetailsViewModel] provider to update the UI with the
    // selected return date.
    ref.watch(copyDetailsViewModelProvider(copy));
    // Access [CopyDetailsViewModel] to fetch and select the return date.
    final CopyDetailsViewModel model =
        ref.watch(copyDetailsViewModelProvider(copy).notifier);
    // Check if the return date is selected.
    final bool returnDateNotSelected = !model.isReturnDateSelected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Return Date',
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(letterSpacing: 1.5),
        ),
        SizedBox(height: 4),
        InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: returnDateNotSelected
                  ? Border.all(color: Theme.of(context).colorScheme.error)
                  : null,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.date_range, size: 24),
                SizedBox(width: 8),
                Text(
                  model.returnDate?.prettify ?? 'Select Return Date',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          onTap: () => model.selectReturnDate(context),
        ),
        if (returnDateNotSelected) ...[
          SizedBox(height: 4),
          Text(
            'Please select the return date',
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
