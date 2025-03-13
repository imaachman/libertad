import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

class OverdueFilterTile extends ConsumerWidget {
  const OverdueFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(issuedCopiesListViewModelProvider);
    final IssuedCopiesListViewModel model =
        ref.watch(issuedCopiesListViewModelProvider.notifier);

    return FilterTile(
      name: 'Overdue',
      expanded: model.overdueFilter != null,
      field: Row(
        children: [
          Switch(
            value: model.overdueFilter ?? false,
            onChanged: model.setOverdueFilter,
          ),
          SizedBox(width: 8),
          Text(
            (model.overdueFilter == null
                    ? 'unfiltered'
                    : model.overdueFilter!
                        ? 'return date passed'
                        : 'return date due')
                .toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      clearFilter: model.clearOverdueFilter,
    );
  }
}
