import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/screens/book_list_tile.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';

import '../../../data/models/book.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve books data and actively watch for changes.
    final AsyncValue<List<Book>> booksData =
        ref.watch(booksListViewModelProvider);
    final List<Book> books = booksData.value ?? [];

    return ListView.separated(
      itemCount: books.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return BookListTile(
          book: books[index],
          index: index,
        );
      },
    );
  }
}
