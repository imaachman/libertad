import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/features/borrowers/viewmodels/borrowers_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

/// Allows defining the membership start date range to filter the borrowers by.
class MembershipStartDateFilterTile extends ConsumerWidget {
  const MembershipStartDateFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for changes to update the UI with the latest data.
    ref.watch(borrowersListViewModelProvider);
    final BorrowersListViewModel model =
        ref.watch(borrowersListViewModelProvider.notifier);

    return FilterTile(
      name: 'Membership Start Date',
      expanded: model.oldestMembershipStartDateFilter != null ||
          model.newestMembershipStartDateFilter != null,
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
                        model.oldestMembershipStartDateFilter?.prettifyDate ??
                            'oldest',
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
              onTap: () => model.selectOldestMembershipStartDateFilter(context),
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
                        model.newestMembershipStartDateFilter?.prettifyDate ??
                            'newest',
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
              onTap: () => model.selectNewestMembershipStartDateFilter(context),
            ),
          ),
        ],
      ),
      clearFilter: model.clearIssueDateFilter,
    );
  }
}
