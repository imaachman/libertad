import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_tile.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';

/// Page with all the issued copies in the database displayed in a list view.
class IssuedCopiesPage extends ConsumerWidget {
  const IssuedCopiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve issued copies data and actively watch for changes.
    final AsyncValue<List<BookCopy>> issuedCopies =
        ref.watch(issuedCopiesListViewModelProvider);

    // Check for error and loading states and build the widget accordingly.
    return issuedCopies.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(
            child: Text(
              'No books issued yet!\nThe books you issue will appear here.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          );
        }
        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: kSmallPhone),
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 64),
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(height: 0),
              itemBuilder: (context, index) =>
                  IssuedCopyTile(copy: data[index], index: index),
            ),
          ),
        );
      },
      error: (error, stackTrace) =>
          Center(child: Text('An unexpected error has occured.')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
