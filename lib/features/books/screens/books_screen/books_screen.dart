import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/screens/books_screen/book_list_tile.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';

import '../../../../data/models/book.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve books data and actively watch for changes.
    final AsyncValue<List<Book>> books = ref.watch(booksListViewModelProvider);

    // Check for error and loading states and build the widget accordingly.
    return books.when(
      data: (data) => ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return BookListTile(
            book: data[index],
            index: index,
          );
        },
      ),
      error: (error, stackTrace) =>
          Center(child: Text('An unexpected error has occured.')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
