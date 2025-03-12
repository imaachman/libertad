import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/issue_status.dart';
import 'package:libertad/features/books/viewmodels/books_list_viewmodel.dart';
import 'package:libertad/widgets/filter_tile.dart';

class IssueStatusFilterTile extends ConsumerWidget {
  const IssueStatusFilterTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(booksListViewModelProvider);
    final BooksListViewModel model =
        ref.watch(booksListViewModelProvider.notifier);

    return FilterTile(
      name: 'Availability',
      expanded: model.issueStatusFilter != null,
      field: Row(
        children: [
          Switch(
            value: model.issueStatusFilter == IssueStatus.available,
            onChanged: model.setIssueStatusFilter,
          ),
          SizedBox(width: 8),
          Text(
            (model.issueStatusFilter == null
                    ? 'unfiltered'
                    : model.issueStatusFilter!.name)
                .toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      clearFilter: model.clearIssueStatusFilter,
    );
  }
}
