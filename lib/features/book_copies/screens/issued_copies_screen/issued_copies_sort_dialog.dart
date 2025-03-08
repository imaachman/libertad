import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/issued_copy_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';

class IssuedCopiesSortDialog extends ConsumerWidget {
  const IssuedCopiesSortDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(issuedCopiesListViewModelProvider);
    final IssuedCopiesListViewModel model =
        ref.watch(issuedCopiesListViewModelProvider.notifier);

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
          ...IssuedCopySort.values.map(
            (bookSort) => ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  bookSort.prettify,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              leading: Icon(bookSort.icon),
              trailing: bookSort == model.bookSort
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
              tileColor: bookSort == model.bookSort
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
              onTap: () async {
                await model.sort(bookSort);
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
