import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

class IssueDateFilterTile extends ConsumerWidget {
  const IssueDateFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(issuedCopiesListViewModelProvider);
    final IssuedCopiesListViewModel model =
        ref.watch(issuedCopiesListViewModelProvider.notifier);

    return FilterTile(
      name: 'Issue Date',
      expanded: model.oldestIssueDateFilter != null ||
          model.newestIssueDateFilter != null,
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
                        model.oldestIssueDateFilter?.prettifyDate ?? 'oldest',
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
              onTap: () => model.selectOldestIssueDateFilter(context),
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
                        model.newestIssueDateFilter?.prettifyDate ?? 'newest',
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
              onTap: () => model.selectNewestIssueDateFilter(context),
            ),
          ),
        ],
      ),
      clearFilter: model.clearIssueDateFilter,
    );
  }
}
