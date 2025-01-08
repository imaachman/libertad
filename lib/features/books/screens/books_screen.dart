import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/mock/mock_books.dart';
import 'package:libertad/widgets/book_list_tile.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
