import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/features/book_copies/viewmodels/issued_copies_list_viewmodel.dart';

class IssuedBooksPage extends ConsumerWidget {
  const IssuedBooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve issued copies data and actively watch for changes.
    final AsyncValue<List<BookCopy>> issuedCopies =
        ref.watch(issuedCopiesListViewModelProvider);

    // Check for error and loading states and build the widget accordingly.
    return issuedCopies.when(
      data: (data) => Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: kSmallPhone),
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 64),
            physics: BouncingScrollPhysics(),
            itemCount: data.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index].id.toString()),
              );
            },
          ),
        ),
      ),
      error: (error, stackTrace) =>
          Center(child: Text('An unexpected error has occured.')),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
