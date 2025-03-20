import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

/// Allows defining the release date range to filter the books by.
class ReleaseDateFilterTile extends ConsumerWidget {
  const ReleaseDateFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for changes to update the UI with the latest data.
    ref.watch(booksListViewModelProvider);
    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    return FilterTile(
      name: 'Release Date',
      expanded: model.oldestReleaseDateFilter != null ||
          model.newestReleaseDateFilter != null,
      field: Row(
        children: [
          SizedBox(
            width: 120,
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.date_range, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        model.oldestReleaseDateFilter?.prettifyDate ?? 'oldest',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => model.selectOldestReleaseDateFilter(context),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.date_range, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        model.newestReleaseDateFilter?.prettifyDate ?? 'newest',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => model.selectNewestReleaseDateFilter(context),
            ),
          ),
        ],
      ),
      clearFilter: model.clearReleaseDateFilter,
    );
  }
}
