import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/viewmodels/borrower_details_viewmodel.dart';

/// Dialog that allows the user to accept fine and remove borrower's defaulter
/// status.
class FineDialog extends ConsumerWidget {
  final Borrower borrower;

  const FineDialog({super.key, required this.borrower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BorrowerDetailsViewModel model =
        ref.read(borrowerDetailsViewModelProvider(borrower).notifier);

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
                  'Pay Fine',
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
                    text: borrower.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text: ' has a pending fine of ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: '\$${borrower.fineDue.toInt()}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  TextSpan(
                    text:
                        '. Would you like to accept it in full and remove their ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: 'defaulter',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  TextSpan(
                    text: ' status?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => model.acceptFine(context),
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
                  'Accept Fine',
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
