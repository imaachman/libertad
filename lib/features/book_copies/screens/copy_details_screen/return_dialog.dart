import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/features/book_copies/viewmodels/copy_details_viewmodel.dart';

class ReturnDialog extends ConsumerWidget {
  final BookCopy copy;

  const ReturnDialog({super.key, required this.copy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CopyDetailsViewModel model =
        ref.read(copyDetailsViewModelProvider(copy).notifier);

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
                  'Return Copy',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(height: 0),
          Padding(
            padding: const EdgeInsets.all(16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Copy ${copy.id}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text: ', issued on ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: copy.issueDate!.prettifyDateSmart,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text: ' to ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: copy.currentBorrower.value!.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text:
                        ', ${copy.returnDatePassed ? 'was supposed' : 'is due'} to return on ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: copy.returnDate!.prettifyDateSmart,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: copy.returnDatePassed
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text: '. Would you like to return it today, i.e., on ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: DateTime.now().prettifyDate,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text: '?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (copy.returnDatePassed) ...[
                    TextSpan(
                      text: ' A fine of ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '\$${2 * copy.overdueBy()}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    TextSpan(
                      text: ' will be levied.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ]
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => model.returnBook(context),
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
                  copy.returnDatePassed
                      ? 'Return copy with fine'
                      : 'Return Copy',
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
