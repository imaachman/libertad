import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/borrowers/viewmodels/borrowers_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

class ActiveFilterTile extends ConsumerWidget {
  const ActiveFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(borrowersListViewModelProvider);
    final BorrowersListViewModel model =
        ref.watch(borrowersListViewModelProvider.notifier);

    return FilterTile(
      name: 'Active',
      expanded: model.activeFilter != null,
      field: Row(
        children: [
          Switch(
            value: model.activeFilter ?? false,
            onChanged: model.setActiveFilter,
          ),
          SizedBox(width: 8),
          Text(
            (model.activeFilter == null
                    ? 'unfiltered'
                    : model.activeFilter!
                        ? 'active member'
                        : 'past member')
                .toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      clearFilter: model.clearActiveFilter,
    );
  }
}
