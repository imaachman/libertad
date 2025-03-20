import 'package:flutter/material.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:libertad/widgets/profile_picture.dart';

/// List tile displaying brief info about the borrower, such as name and joining
/// date. Navigates to borrower's details page.
class BorrowerListTile extends StatelessWidget {
  final Borrower borrower;
  final int index;

  const BorrowerListTile(
      {super.key, required this.borrower, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.borrower, arguments: borrower),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${index + 1}.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(width: 12),
            SizedBox.square(
              dimension: 40,
              child: ProfilePicture(
                imageFilePath: borrower.profilePicture,
                iconSize: 30,
                borderWidth: 2,
              ),
            ),
          ],
        ),
        title: Text(borrower.name),
        titleTextStyle: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        subtitle: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'joined ',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontStyle: FontStyle.italic)),
              TextSpan(
                text: borrower.membershipStartDate.prettifyDate,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.italic,
                      decorationColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (borrower.isDefaulter)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).colorScheme.errorContainer),
                child: Center(
                  child: Text(
                    'D',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.error,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (!borrower.isActive && borrower.isDefaulter) SizedBox(width: 8),
            if (!borrower.isActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).colorScheme.primaryContainer),
                child: Center(
                  child: Text(
                    'I',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ));
  }
}
