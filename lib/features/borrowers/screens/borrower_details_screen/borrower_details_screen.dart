import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/borrowers/viewmodels/borrower_details_viewmodel.dart';
import 'package:libertad/widgets/profile_picture.dart';

class BorrowerDetailsPage extends ConsumerWidget {
  final Borrower borrower;

  const BorrowerDetailsPage({super.key, required this.borrower});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(borrowerDetailsViewModelProvider(borrower));
    final BorrowerDetailsViewModel model =
        ref.watch(borrowerDetailsViewModelProvider(borrower).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrower Details'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Edit',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
                onTap: () => model.showBorrowerEditor(context),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Delete',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ],
                ),
                onTap: () => model.showDeletionDialog(context),
              ),
            ],
          )
        ],
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
                  child: ProfilePicture(
                    imageFilePath: model.borrower.profilePicture,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  model.borrower.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Member from ',
                              style: Theme.of(context).textTheme.labelLarge),
                          TextSpan(
                            text: borrower.membershipStartDate.prettify,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).primaryColor,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          TextSpan(
                            text: ' to ',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          TextSpan(
                            text: borrower.membershipStartDate
                                .copyWith(
                                    month: borrower.membershipStartDate.month +
                                        borrower.membershipDuration)
                                .prettify,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).primaryColor,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width / 1.2,
                //   constraints: BoxConstraints(maxWidth: kSmallPhone),
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   child: Text(borrower.bio),
                // ),
                // Container(
                //   constraints: BoxConstraints(maxWidth: kSmallPhone + 48),
                //   child: Divider(height: 48),
                // ),
                // Column(
                //   children: [
                //     Text(
                //       'Books',
                //       style: Theme.of(context)
                //           .textTheme
                //           .headlineLarge
                //           ?.copyWith(fontWeight: FontWeight.bold),
                //     ),
                //     const SizedBox(height: 16),
                //     ...List.generate(
                //       author.books.length,
                //       (index) {
                //         final Book book = author.books.toList()[index];
                //         return BookListTile(
                //           book: book,
                //           index: index,
                //           minimal: true,
                //         );
                //       },
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
