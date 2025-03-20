import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/borrowers/viewmodels/borrowers_list_viewmodel.dart';

import 'active_filter_tile.dart';
import 'defaulter_filter_tile.dart';
import 'membership_start_date_filter_tile.dart';

/// Dialog that allows the user to apply filters to the borrowers list.
class BorrowerFilterDialog extends ConsumerWidget {
  const BorrowerFilterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BorrowersListViewModel model =
        ref.watch(borrowersListViewModelProvider.notifier);

    return Dialog(
      shape: RoundedRectangleBorder(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: model.clearAll,
                  child: Text('clear all'),
                ),
              ],
            ),
          ),
          Divider(height: 0),
          ActiveFilterTile(),
          DefaulterFilterTile(),
          MembershipStartDateFilterTile(),
          Divider(height: 0),
          TextButton(
            onPressed: () => model.applyFilters(context),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).primaryColor,
              ),
            ),
            child: SizedBox(
              height: 48,
              child: Center(
                child: Text(
                  'Apply Filters',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
