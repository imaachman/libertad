import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/features/borrowers/viewmodels/borrowers_list_viewmodel.dart';

/// Dialog that allows the user to select one of the sorting options for the
/// borrower, and select the sort order as well.
class BorrowerSortDialog extends ConsumerWidget {
  const BorrowerSortDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for changes to update the UI with the latest data.
    ref.watch(borrowersListViewModelProvider);
    final BorrowersListViewModel model =
        ref.watch(borrowersListViewModelProvider.notifier);

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
          ...BorrowerSort.values.map(
            (borrowerSort) => ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(
                  borrowerSort.prettify,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              leading: Icon(borrowerSort.icon),
              trailing: borrowerSort == model.borrowerSort
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
              tileColor: borrowerSort == model.borrowerSort
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
              onTap: () async {
                await model.sort(borrowerSort);
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
