import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/book_copies/viewmodels/borrowers_search_viewmodel.dart';
import 'package:libertad/widgets/profile_picture.dart';

class BorrowersSearchPage extends ConsumerWidget {
  final String query;
  final void Function(BuildContext context, Borrower? result) close;

  const BorrowersSearchPage({
    super.key,
    required this.query,
    required this.close,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Borrower>> borrowers =
        ref.watch(borrowersSearchViewModelProvider(query));

    return borrowers.when(
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final Borrower borrower = data[index];
          return ListTile(
            onTap: () => close(context, borrower),
            leading: ProfilePicture(
              imageFilePath: borrower.profilePicture,
              borderWidth: 2,
              iconSize: 30,
            ),
            title: Text(borrower.name),
            titleTextStyle: Theme.of(context).textTheme.bodyLarge,
            subtitle: Text(
                'member since ${borrower.membershipStartDate.prettifyDate}'),
            subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
          );
        },
      ),
      error: (error, stacktrace) =>
          Center(child: Text('Something unexpected has occured')),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
