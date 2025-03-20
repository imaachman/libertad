import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/book_copies/viewmodels/borrowers_search_viewmodel.dart';
import 'package:libertad/widgets/profile_picture.dart';

/// Page that displays borrowers list which can be filtered with the search
/// query.
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
    // Retrieve filtered borrowers data and actively watch for changes.
    final AsyncValue<List<Borrower>> borrowers =
        ref.watch(borrowersSearchViewModelProvider(query));

    // Check for error and loading states and build the widget accordingly.
    return borrowers.when(
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final Borrower borrower = data[index];
          return ListTile(
            onTap: () => close(context, borrower),
            leading: SizedBox.square(
              dimension: 40,
              child: ProfilePicture(
                imageFilePath: borrower.profilePicture,
                iconSize: 30,
                borderWidth: 2,
              ),
            ),
            title: Text(borrower.name),
            titleTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'joined ',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontStyle: FontStyle.italic)),
                  TextSpan(
                    text: borrower.membershipStartDate.prettifyDate,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                          decorationColor: Theme.of(context).primaryColor,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ),
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
