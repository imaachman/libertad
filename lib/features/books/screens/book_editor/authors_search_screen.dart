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

    return authors.when(
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final Author author = data[index];
          return InkWell(
            onTap: () => close(context, author),
            child: ListTile(
              // TODO: Replace with author image.
              leading: const Icon(Icons.person),
              title: Text(author.name),
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              subtitle: Text('author of "${author.books.first}"'),
              subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
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
