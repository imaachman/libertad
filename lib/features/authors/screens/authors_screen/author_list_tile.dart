import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:libertad/widgets/profile_picture.dart';

class AuthorListTile extends StatelessWidget {
  final Author author;
  final int index;

  const AuthorListTile({super.key, required this.author, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.author, arguments: author),
      child: ListTile(
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
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        subtitle: Text('author of "${author.books.first.title}"'),
        subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
