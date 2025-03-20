import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

/// Allows defining the return date range to filter the copies by.
class ReturnDateFilterTile extends ConsumerWidget {
  const ReturnDateFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(issuedCopiesListViewModelProvider);
    final IssuedCopiesListViewModel model =
        ref.watch(issuedCopiesListViewModelProvider.notifier);

    return FilterTile(
      name: 'Return Date',
      expanded: model.oldestReturnDateFilter != null ||
          model.newestReturnDateFilter != null,
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
                        model.oldestReturnDateFilter?.prettifyDate ?? 'oldest',
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
              onTap: () => model.selectOldestReturnDateFilter(context),
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
                        model.newestReturnDateFilter?.prettifyDate ?? 'newest',
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
              onTap: () => model.selectNewestReturnDateFilter(context),
            ),
          ),
        ],
      ),
      clearFilter: model.clearReturnDateFilter,
    );
  }
}
