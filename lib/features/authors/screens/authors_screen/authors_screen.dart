import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/authors/screens/authors_screen/author_list_tile.dart';
import 'package:libertad/features/authors/viewmodels/authors_list_viewmodel.dart';

class AuthorsPage extends ConsumerWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve authors data and actively watch for changes.
    final AsyncValue<List<Author>> authors =
        ref.watch(authorsListViewModelProvider);

    // Check for error and loading states and build the widget accordingly.
    return authors.when(
        data: (data) => ListView.separated(
              padding: const EdgeInsets.only(bottom: 64),
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return AuthorListTile(
                  author: data[index],
                  index: index,
                );
              },
            ),
        error: (error, stackTrace) =>
            Center(child: Text('An unexpected error has occured.')),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
