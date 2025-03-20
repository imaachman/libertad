import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:libertad/widgets/profile_picture.dart';

/// List tile displaying brief info about the author, such as name and one of
/// their book's title. Navigates to author's details page.
class AuthorListTile extends StatelessWidget {
  final Author author;
  final int index;

  const AuthorListTile({super.key, required this.author, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.author, arguments: author),
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
              imageFilePath: author.profilePicture,
              iconSize: 30,
              borderWidth: 2,
            ),
          ),
        ],
      ),
      title: Text(author.name),
      titleTextStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'author of ',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(fontStyle: FontStyle.italic)),
            TextSpan(
              text: author.books.first.title,
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
    );
  }
}
