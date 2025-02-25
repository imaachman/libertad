import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/features/books/screens/book_editor/author_editor_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authors_search_viewmodel.g.dart';

@riverpod
class AuthorsSearchViewModel extends _$AuthorsSearchViewModel {
  Author? newlyCreatedAuthor;

  @override
  Future<List<Author>> build(String query) =>
      DatabaseRepository.instance.searchAuthors(query);

  Future<void> showAuthorEditorDialog(
      BuildContext context, String query) async {
    final Author? result = await showAdaptiveDialog<Author>(
      context: context,
      builder: (context) => AuthorEditorDialog(query: query),
    );
    if (result != null) {
      newlyCreatedAuthor = result;
      ref.notifyListeners();
    }
  }
}
