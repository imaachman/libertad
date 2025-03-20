import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/features/authors/screens/author_editor/author_editor_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authors_search_viewmodel.g.dart';

/// Business logic layer for authors search page.
@riverpod
class AuthorsSearchViewModel extends _$AuthorsSearchViewModel {
  Author? newlyCreatedAuthor;

  /// Search for authors.
  @override
  Future<List<Author>> build(String query) =>
      DatabaseRepository.instance.searchAuthors(query);

  /// Shows author editor dialog and creates a new author with its result.
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
