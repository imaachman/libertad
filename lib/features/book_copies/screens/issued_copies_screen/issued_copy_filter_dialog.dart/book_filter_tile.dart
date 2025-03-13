import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

class BookFilterTile extends ConsumerWidget {
  const BookFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(issuedCopiesListViewModelProvider);
    final IssuedCopiesListViewModel model =
        ref.watch(issuedCopiesListViewModelProvider.notifier);

    return FilterTile(
      name: 'Book',
      expanded: model.bookFilter != null,
      field: PopupMenuButton(
        tooltip: 'Select book',
        onSelected: model.selectBookFilter,
        itemBuilder: (context) {
          return model.allBooks.map(
            (book) {
              return PopupMenuItem(
                value: book,
                child: Text(book.title),
              );
            },
          ).toList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          width: 200,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.book, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  model.bookFilter?.title ?? 'Select book',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      clearFilter: model.clearBookFilter,
    );
  }
}
