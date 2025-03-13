import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class ReleaseDateField extends ConsumerWidget {
  final Book? book;

  const ReleaseDateField({super.key, this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to [BookEditorViewModel] provider to update the release date in
    // the UI.
    ref.watch(bookEditorViewModelProvider(book: book));
    // Access [BookEditorViewModel] to get the release date.
    final BookEditorViewModel model =
        ref.watch(bookEditorViewModelProvider(book: book).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Release Date',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.date_range, size: 24),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    model.releaseDate.prettifyDate,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          onTap: () => model.selectReleaseDate(context),
        ),
      ],
    );
  }
}
