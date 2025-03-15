import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';

class BookDeletionDialog extends StatelessWidget {
  final Book book;
  final VoidCallback onDelete;

  const BookDeletionDialog({
    super.key,
    required this.book,
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
            TextSpan(text: 'Are you sure you want to delete '),
            TextSpan(
              text: book.title,
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
