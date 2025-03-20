import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

class GenreFilterTile extends ConsumerWidget {
  const GenreFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(booksListViewModelProvider);
    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    return FilterTile(
      name: 'Genre',
      expanded: model.genreFilter != null,
      field: PopupMenuButton(
        tooltip: 'Select genre',
        onSelected: model.selectGenreFilter,
        itemBuilder: (context) {
          return Genre.values.map((genre) {
            return PopupMenuItem(
              value: genre,
              child: Text(genre.prettify),
            );
          }).toList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.category, size: 20),
              SizedBox(width: 8),
              Text(
                model.genreFilter?.prettify ?? 'Select genre',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
      clearFilter: model.clearGenreFilter,
    );
  }
}
