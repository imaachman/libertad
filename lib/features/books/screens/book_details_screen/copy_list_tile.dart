import 'package:flutter/material.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/navigation/routes.dart';

/// List tile displaying brief info about the book copy, such as ID, book, and
/// availability. Navigates to copy's details page.
class CopyListTile extends StatelessWidget {
  final BookCopy copy;
  final int index;

  const CopyListTile({super.key, required this.copy, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.bookCopy, arguments: copy),
      leading: Text(
        '${index + 1}.',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      title: Text('Copy ${copy.id}'),
      titleTextStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.bold),
      trailing: copy.isIssued
          ? RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'borrowed by ',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextSpan(
                    text: copy.currentBorrower.value?.name,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ],
              ),
            )
          : Text(
              'Available',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
    );
  }
}
