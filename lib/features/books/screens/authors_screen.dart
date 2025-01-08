import 'package:flutter/material.dart';
import 'package:libertad/data/mock/mock_authors.dart';
import 'package:libertad/widgets/author_list_tile.dart';

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: mockAuthors.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return AuthorListTile(
          author: mockAuthors[index],
          index: index,
        );
      },
    );
  }
}
