import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/screens/books_screen/book_filter_dialog/author_filter_tile.dart';
import 'package:libertad/features/books/screens/books_screen/book_filter_dialog/genre_filter_tile.dart';
import 'package:libertad/features/books/screens/books_screen/book_filter_dialog/issue_status_filter_tile.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';

import 'total_copies_filter_tile.dart';

class BookFilterDialog extends ConsumerStatefulWidget {
  const BookFilterDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookFilterDialogState();
}

class _BookFilterDialogState extends ConsumerState<BookFilterDialog> {
  late final TextEditingController minController;
  late final TextEditingController maxController;

  @override
  void initState() {
    super.initState();
    minController = TextEditingController();
    maxController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    return Dialog(
      shape: RoundedRectangleBorder(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => model.clearAll(minController, maxController),
                  child: Text('clear all'),
                ),
              ],
            ),
          ),
          Divider(height: 0),
          GenreFilterTile(),
          AuthorFilterTile(),
          IssueStatusFilterTile(),
          TotalCopiesFilterTile(
            minController: minController,
            maxController: maxController,
          ),
          Divider(height: 0),
          TextButton(
            onPressed: () async {
              await model.applyFilters();
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor,
              ),
            ),
            child: SizedBox(
              height: 48,
              child: Center(
                child: Text(
                  'Apply Filters',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }
}
