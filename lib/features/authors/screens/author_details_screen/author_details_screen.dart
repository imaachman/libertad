import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/core/constants/breakpoints.dart';
import 'package:libertad/core/utils/extensions.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/widgets/book_list_tile.dart';
import 'package:libertad/features/authors/viewmodels/author_details_viewmodel.dart';
import 'package:libertad/widgets/profile_picture.dart';

/// Page with author's details such as their name, profile picture, and the
/// books written by them.
class AuthorDetailsPage extends ConsumerWidget {
  final Author author;

  const AuthorDetailsPage({super.key, required this.author});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for changes to update the UI with the latest data.
    ref.watch(authorDetailsViewModelProvider(author));
    final AuthorDetailsViewModel model =
        ref.watch(authorDetailsViewModelProvider(author).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Details'),
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
                onTap: () => model.showAuthorEditorDialog(context),
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
                    imageFilePath: author.profilePicture,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  author.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  constraints: BoxConstraints(maxWidth: kSmallPhone),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(author.bio),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: kSmallPhone + 48),
                  child: Divider(height: 48),
                ),
                Column(
                  children: [
                    Text(
                      'Books',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(
                      author.books.length,
                      (index) {
                        final Book book = author.books.toList()[index];
                        return BookListTile(
                          book: book,
                          index: index,
                          minimal: true,
                        );
                      },
                    ),
                  ],
                ),
                Divider(height: 48),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Created: ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: author.createdAt.prettifyDateAndTime,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Updated: ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: author.updatedAt.prettifyDateAndTime,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
