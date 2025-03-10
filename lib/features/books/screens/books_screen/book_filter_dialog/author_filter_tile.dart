import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

class AuthorFilterTile extends ConsumerWidget {
  const AuthorFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(booksListViewModelProvider);
    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    return FilterTile(
      name: 'Author',
      expanded: model.authorFilter != null,
      field: PopupMenuButton(
        tooltip: 'Select author',
        onSelected: model.selectAuthorFilter,
        itemBuilder: (context) {
          return model.allAuthors.map(
            (author) {
              return PopupMenuItem(
                value: author,
                child: Text(author.name),
              );
            },
          ).toList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, size: 20),
              SizedBox(width: 8),
              Text(
                model.authorFilter?.name ?? 'Select author',
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
      clearFilter: model.clearAuthorFilter,
    );
  }
}
