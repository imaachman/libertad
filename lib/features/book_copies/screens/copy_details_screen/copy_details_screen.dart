import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/borrower_field.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/return_date_field.dart';
import 'package:libertad/features/book_copies/viewmodels/copy_details_viewmodel.dart';
import 'package:libertad/features/borrowers/screens/borrowers_screen/borrower_list_tile.dart';
import 'package:libertad/widgets/book_cover.dart';

class CopyDetailsPage extends ConsumerWidget {
  final BookCopy copy;

  const CopyDetailsPage({super.key, required this.copy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(copyDetailsViewModelProvider(copy));
    final CopyDetailsViewModel model =
        ref.watch(copyDetailsViewModelProvider(copy).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Copy Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: kSmallPhone / 2),
                  width: MediaQuery.of(context).size.width / 2,
                  child: BookCover(
                    book: copy.book.value!,
                    titleStyle: Theme.of(context).textTheme.titleLarge,
                    authorStyle: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Copy ${copy.id}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  copy.status.name.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                ),
                SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ReturnDateField(copy: copy),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: BorrowerField(copy: copy),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: model.issueBook,
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: kSmallPhone / 2),
                    width: MediaQuery.of(context).size.width / 2,
                    height: 48,
                    child: Center(
                      child: Text(
                        'Issue Book',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: kSmallPhone + 48),
                  child: Divider(height: 48),
                ),
                Column(
                  children: [
                    Text(
                      'Past Borrowers',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ...List.generate(
                      copy.previousBorrowers.length,
                      (index) {
                        final Borrower borrower =
                            copy.previousBorrowers.toList()[index];
                        return BorrowerListTile(
                            borrower: borrower, index: index);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
