import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/features/book_copies/viewmodels/copy_details_viewmodel.dart';

class IssueDateField extends ConsumerWidget {
  final BookCopy copy;

  const IssueDateField({super.key, required this.copy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the [CopyDetailsViewModel] provider to update the UI with the
    // selected issue date.
    ref.watch(copyDetailsViewModelProvider(copy));
    // Access [CopyDetailsViewModel] to fetch and select the issue date.
    final CopyDetailsViewModel model =
        ref.watch(copyDetailsViewModelProvider(copy).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Issue Date',
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(letterSpacing: 1.5),
        ),
        SizedBox(height: 4),
        InkWell(
          child: Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.date_range, size: 24),
                SizedBox(width: 8),
                Text(
                  model.returnDate?.prettify ?? 'Select Issue Date',
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
      ],
    );
  }
}
