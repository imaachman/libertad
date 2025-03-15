import 'package:flutter/material.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:libertad/widgets/profile_picture.dart';

class BorrowerListTile extends StatelessWidget {
  final Borrower borrower;
  final int index;

  const BorrowerListTile(
      {super.key, required this.borrower, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.borrower, arguments: borrower),
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
      trailing: borrower.isActive
          ? null
          : Container(
              padding: const EdgeInsets.all(8),
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context)
                    .colorScheme
                    .tertiaryContainer
                    .withAlpha(180),
              ),
              child: Center(
                child: Text(
                  'INACTIVE',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 9),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
