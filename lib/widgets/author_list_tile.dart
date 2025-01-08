import 'package:flutter/material.dart';
import 'package:libertad/data/models/author_model.dart';

class AuthorListTile extends StatelessWidget {
  final AuthorModel author;
  final int index;

  const AuthorListTile({super.key, required this.author, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${index + 1}.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(width: 12),
          // TODO: Replace with author images.
          const Icon(Icons.person),
        ],
      ),
      title: Text(author.name),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      subtitle: Text('author of "${author.books.first}"'),
      subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
    );
  }
}
