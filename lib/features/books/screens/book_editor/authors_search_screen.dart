import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/viewmodels/authors_search_viewmodel.dart';

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
          InkWell(
            onTap: () => ref
                .read(authorsSearchViewModelProvider(query).notifier)
                .showAuthorCreationDialog(context, query),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                boxShadow: [BoxShadow(offset: Offset(0, -10), blurRadius: 10)],
              ),
              child: ListTile(
                // TODO: Replace with author image.
                leading: const Icon(Icons.person_add_alt_rounded),
                iconColor: Theme.of(context).colorScheme.primary,
                title: Text('CREATE A NEW AUTHOR'),
                titleTextStyle: Theme.of(context).textTheme.bodyLarge,
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
                  InkWell(
                    onTap: () => close(context, newlyAddedAuthor),
                    child: ListTile(
                      // TODO: Replace with author image.
                      leading: const Icon(Icons.person),
                      title: Text(newlyAddedAuthor.name),
                      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                      subtitle: Text('newly created author'),
                      subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ...data.map(
                  (author) => InkWell(
                    onTap: () => close(context, author),
                    child: ListTile(
                      // TODO: Replace with author image.
                      leading: const Icon(Icons.person),
                      title: Text(author.name),
                      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                      subtitle: Text('author of "${author.books.first}"'),
                      subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
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
