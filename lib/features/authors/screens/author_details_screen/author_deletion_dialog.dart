import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';

class AuthorDeletionDialog extends StatelessWidget {
  final Author author;
  final VoidCallback onDelete;

  const AuthorDeletionDialog({
    super.key,
    required this.author,
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
            TextSpan(text: 'Are you sure you want to delete author '),
            TextSpan(
              text: author.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
                text: '? This will also delete all the books written by them.'),
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
