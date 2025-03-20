import 'package:flutter/material.dart';
import 'package:libertad/data/models/borrower.dart';

/// Dialog that allows the user to confirm borrower's deletion.
class BorrowerDeletionDialog extends StatelessWidget {
  final Borrower borrower;
  final VoidCallback onDelete;

  const BorrowerDeletionDialog({
    super.key,
    required this.borrower,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(),
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
          onPressed: onDelete,
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
