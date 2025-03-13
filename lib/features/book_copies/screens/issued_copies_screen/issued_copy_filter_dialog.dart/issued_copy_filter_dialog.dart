import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_filter_dialog.dart/book_filter_tile.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_filter_dialog.dart/borrower_filter_tile.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_filter_dialog.dart/issue_date_filter_tile.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_filter_dialog.dart/overdue_filter_tile.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_filter_dialog.dart/return_date_filter_tile.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';

class IssuedCopyFilterDialog extends ConsumerWidget {
  const IssuedCopyFilterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IssuedCopiesListViewModel model =
        ref.watch(issuedCopiesListViewModelProvider.notifier);

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
          BookFilterTile(),
          BorrowerFilterTile(),
          OverdueFilterTile(),
          IssueDateFilterTile(),
          ReturnDateFilterTile(),
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
