import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/viewmodels/borrowers_list_viewmodel.dart';

class BorrowersPage extends ConsumerWidget {
  const BorrowersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve borrowers data and actively watch for changes.
    final AsyncValue<List<Borrower>> borrowers =
        ref.watch(borrowersListViewModelProvider);

    // Check for error and loading states and build the widget accordingly.
    return borrowers.when(
        data: (data) => ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].name),
                );
              },
            ),
        error: (error, stackTrace) =>
            Center(child: Text('An unexpected error has occured.')),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
