import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/screens/books_screen/book_filter_dialog/author_filter_tile.dart';
import 'package:libertad/features/books/screens/books_screen/book_filter_dialog/genre_filter_tile.dart';
import 'package:libertad/features/books/screens/books_screen/book_filter_dialog/issue_status_filter_tile.dart';

import 'total_copies_filter_tile.dart';

class BookFilterDialog extends ConsumerWidget {
  const BookFilterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'Filter',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Divider(height: 0),
          GenreFilterTile(),
          AuthorFilterTile(),
          IssueStatusFilterTile(),
          TotalCopiesFilterTile(),
        ],
      ),
    );
  }
}
