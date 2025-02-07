import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';

class GenreField extends ConsumerWidget {
  final Book? book;

  const GenreField({super.key, this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the [BookEditorViewModel] provider to check if a genre is
    // selected and to show the selected genre in the UI.
    ref.watch(bookEditorViewModelProvider(book: book));

    // Access [BookEditorViewModel] to get the selected genre.
    final BookEditorViewModel model =
        ref.watch(bookEditorViewModelProvider(book: book).notifier);
    // Check if a genre is selected.
    final bool genreNotSelected = !model.isGenreSelected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genre',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        PopupMenuButton(
          tooltip: 'Select genre',
          onSelected: model.setGenre,
          itemBuilder: (context) {
            return Genre.values.map((genre) {
              return PopupMenuItem(
                value: genre,
                child: Text(genre.name),
              );
            }).toList();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: genreNotSelected
                  ? Border.all(color: Theme.of(context).colorScheme.error)
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.category, size: 24),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    model.genre?.name ?? 'Select genre',
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
        ),
        if (genreNotSelected) ...[
          SizedBox(height: 4),
          Text(
            'Please select a genre',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ]
      ],
    );
  }
}
