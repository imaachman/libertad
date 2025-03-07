import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/features/books/viewmodels/book_details_viewmodel.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:libertad/widgets/book_cover.dart';

class BookDetailsPage extends ConsumerWidget {
  final Book book;

  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(bookDetailsViewModelProvider(book));
    final BookDetailsViewModel model =
        ref.watch(bookDetailsViewModelProvider(book).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
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
                onTap: () => model.showBookEditor(context),
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
                  child: BookCover(
                    book: book,
                    titleStyle: Theme.of(context).textTheme.titleLarge,
                    authorStyle: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  book.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  book.author.value!.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  constraints: BoxConstraints(maxWidth: kSmallPhone),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(book.summary),
                ),
                SizedBox(height: 16),
                Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'First published on ',
                              style: Theme.of(context).textTheme.labelLarge),
                          TextSpan(
                            text: book.releaseDate.prettify,
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
                    SizedBox(width: 32),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Genre: ',
                              style: Theme.of(context).textTheme.labelLarge),
                          TextSpan(
                            text: book.genre.name,
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
                Container(
                  constraints: BoxConstraints(maxWidth: kSmallPhone + 48),
                  child: Divider(height: 48),
                ),
                Column(
                  children: [
                    Text(
                      'Copies',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ...List.generate(
                      book.totalCopies.length,
                      (index) {
                        final BookCopy copy = book.totalCopies.toList()[index];
                        return ListTile(
                          onTap: () => Navigator.of(context)
                              .pushNamed(Routes.bookCopy, arguments: copy),
                          leading: Text(
                            '${index + 1}.',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          title: Text('Copy ${copy.id}'),
                          titleTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          trailing: copy.status == IssueStatus.issued
                              ? RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'borrowed by ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      TextSpan(
                                        text: copy.currentBorrower.value?.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(
                                  'Available',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                        );
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
