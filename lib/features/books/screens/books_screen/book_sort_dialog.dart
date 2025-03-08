import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';

class BookSortDialog extends ConsumerWidget {
  const BookSortDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(booksListViewModelProvider);
    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    return Dialog(
      shape: RoundedRectangleBorder(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text(
                  'Sort by',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ChoiceChip(
                  padding: const EdgeInsets.all(0),
                  label: Text(
                    'ASC',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  showCheckmark: false,
                  selected: model.selectedSortOrder == SortOrder.ascending,
                  onSelected: (value) =>
                      model.selectSortOrder(SortOrder.ascending),
                ),
                SizedBox(width: 8),
                ChoiceChip(
                  padding: const EdgeInsets.all(0),
                  label: Text(
                    'DSC',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  showCheckmark: false,
                  selected: model.selectedSortOrder == SortOrder.descending,
                  onSelected: (value) =>
                      model.selectSortOrder(SortOrder.descending),
                ),
              ],
            ),
          ),
          Divider(height: 0),
          ...BookSort.values.map(
            (sort) => ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  sort.prettify,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              leading: Icon(sort.icon),
              onTap: () async {
                await model.sortBy(sort);
                if (!context.mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
