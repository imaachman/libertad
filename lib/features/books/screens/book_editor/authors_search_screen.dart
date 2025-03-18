import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/viewmodels/authors_search_viewmodel.dart';
import 'package:libertad/widgets/profile_picture.dart';

class AuthorsSearchPage extends ConsumerWidget {
  final String query;
  final void Function(BuildContext context, Author? result) close;

  const AuthorsSearchPage({
    super.key,
    required this.query,
    required this.close,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Author>> authors =
        ref.watch(authorsSearchViewModelProvider(query));

    final Author? newlyAddedAuthor = ref
        .watch(authorsSearchViewModelProvider(query).notifier)
        .newlyCreatedAuthor;

    return authors.when(
      data: (data) => Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              boxShadow: [BoxShadow(offset: Offset(0, -10), blurRadius: 10)],
            ),
            child: Center(
              child: ListTile(
                onTap: () => ref
                    .read(authorsSearchViewModelProvider(query).notifier)
                    .showAuthorEditorDialog(context, query),
                leading: const Icon(Icons.person_add_alt_rounded),
                iconColor: Theme.of(context).colorScheme.primary,
                title: Text('Create new author'),
                titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                tileColor: Theme.of(context).colorScheme.primaryContainer,
                subtitle: query.isNotEmpty ? Text(query.toUpperCase()) : null,
                subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                if (newlyAddedAuthor != null)
                  ListTile(
                    onTap: () => close(context, newlyAddedAuthor),
                    leading: SizedBox.square(
                      dimension: 40,
                      child: ProfilePicture(
                        imageFilePath: newlyAddedAuthor.profilePicture,
                        iconSize: 30,
                        borderWidth: 2,
                      ),
                    ),
                    title: Text(newlyAddedAuthor.name),
                    titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                    subtitle: Text('newly created author'),
                    subtitleTextStyle: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                ...data.map(
                  (author) => ListTile(
                    onTap: () => close(context, author),
                    leading: SizedBox.square(
                      dimension: 40,
                      child: ProfilePicture(
                        imageFilePath: author.profilePicture,
                        iconSize: 30,
                        borderWidth: 2,
                      ),
                    ),
                    title: Text(author.name),
                    titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                    subtitle: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'author of ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontStyle: FontStyle.italic)),
                          TextSpan(
                            text: author.books.first.title,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic,
                                  decorationColor:
                                      Theme.of(context).primaryColor,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      error: (error, stacktrace) =>
          Center(child: Text('Something unexpected has occured')),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
