import 'package:flutter/material.dart';
import 'package:libertad/data/mock/mock_books.dart';
import 'package:libertad/widgets/book_list_tile.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: mockBooks.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return BookListTile(
          book: mockBooks[index],
          index: index,
        );
      },
    );
  }
}
