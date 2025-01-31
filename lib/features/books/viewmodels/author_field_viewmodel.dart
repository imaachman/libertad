import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/viewmodels/book_editor_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../screens/book_editor/authors_search_delegate.dart';

part 'author_field_viewmodel.g.dart';

@riverpod
class AuthorFieldViewModel extends _$AuthorFieldViewModel {
  @override
  Future<Author?> build() async => null;

  Future<void> showAuthorsSearchView(BuildContext context) async {
    final Author? selectedAuthor = await showSearch<Author?>(
      context: context,
      delegate: AuthorsSearchDelegate(),
    );
    if (selectedAuthor != null) state = AsyncData(selectedAuthor);

    // Update [author] in [BookEditorViewModel] with [selectedAuthor] to add it
    // as the book's author.
    ref.read(bookEditorViewModelProvider().notifier).setAuthor(selectedAuthor);
  }
}
