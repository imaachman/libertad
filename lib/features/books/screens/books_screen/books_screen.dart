import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/widgets/book_list_tile.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';

import '../../../../data/models/book.dart';

class BooksPage extends ConsumerWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve books data and actively watch for changes.
    final AsyncValue<List<Book>> books = ref.watch(booksListViewModelProvider);

    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    // Check for error and loading states and build the widget accordingly.
    return books.when(
      data: (data) => Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: kSmallPhone),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      onPressed: () => model.showSortDialog(context),
                      icon: Icon(Icons.sort_rounded),
                      label: Text('Sort'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.filter_alt),
                      label: Text('Filter'),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 64),
                  physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return BookListTile(
                      book: data[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) =>
          Center(child: Text('An unexpected error has occured.')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
