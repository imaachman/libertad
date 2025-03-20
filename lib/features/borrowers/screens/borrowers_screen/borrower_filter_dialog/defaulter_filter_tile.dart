import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/borrowers/viewmodels/borrowers_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

/// Allows the user to filter the borrowers by defaulter status.
class DefaulterFilterTile extends ConsumerWidget {
  const DefaulterFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for changes to update the UI with the latest data.
    ref.watch(borrowersListViewModelProvider);
    final BorrowersListViewModel model =
        ref.watch(borrowersListViewModelProvider.notifier);

    return FilterTile(
      name: 'Defaulter',
      expanded: model.defaulterFilter != null,
      field: Row(
        children: [
          Switch(
            value: model.defaulterFilter ?? false,
            onChanged: model.setDefaulterFilter,
          ),
          SizedBox(width: 8),
          Text(
            (model.defaulterFilter == null
                    ? 'unfiltered'
                    : model.defaulterFilter!
                        ? 'defaulter'
                        : 'responsible')
                .toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      clearFilter: model.clearDefaulterFilter,
    );
  }
}
