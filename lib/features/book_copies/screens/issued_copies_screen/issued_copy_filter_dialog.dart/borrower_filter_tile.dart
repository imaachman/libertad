import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

/// Allows selecting a borrower to filter the copies by.
class BorrowerFilterTile extends ConsumerWidget {
  const BorrowerFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for changes to update the UI with the latest data.
    ref.watch(issuedCopiesListViewModelProvider);
    final IssuedCopiesListViewModel model =
        ref.watch(issuedCopiesListViewModelProvider.notifier);

    return FilterTile(
      name: 'Borrower',
      expanded: model.borrowerFilter != null,
      field: PopupMenuButton(
        tooltip: 'Select borrower',
        onSelected: model.selectBorrowerFilter,
        itemBuilder: (context) {
          return model.allBorrowers.map(
            (borrower) {
              return PopupMenuItem(
                value: borrower,
                child: Text(borrower.name),
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
              Icon(Icons.person, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  model.borrowerFilter?.name ?? 'Select borrower',
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
      clearFilter: model.clearBorrowerFilter,
    );
  }
}
