import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/borrower.dart';
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
        actions: [
          if (copy.isIssued)
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
                  onTap: () => model.showEditDialog(context, copy),
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
                if (copy.isIssued) ...[
                  Text('issued to'),
                  TextButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
                    ),
                    onPressed: () => Navigator.of(context).pushNamed(
                      '/borrower',
                      arguments: copy.currentBorrower.value,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        copy.currentBorrower.value!.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                if (copy.isAvailable)
                  Text(
                    'AVAILABLE',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => copy.isAvailable
            ? model.showIssueDialog(context, copy)
            : model.showReturnDialog(context, copy),
        icon: Icon(
          copy.isAvailable
              ? Icons.bookmark_added_rounded
              : Icons.handshake_rounded,
          size: 20,
        ),
        label: Text(
          copy.isAvailable ? 'Issue Copy' : 'Return Copy',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
