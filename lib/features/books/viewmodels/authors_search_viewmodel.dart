import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/features/books/screens/book_editor/author_creation_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authors_search_viewmodel.g.dart';

@riverpod
class AuthorsSearchViewModel extends _$AuthorsSearchViewModel {
  @override
  Future<List<Author>> build(String query) =>
      DatabaseRepository.instance.searchAuthors(query);

  void showAuthorCreationDialog(BuildContext context, String query) {
    showAdaptiveDialog<Author>(
      context: context,
      builder: (context) => AuthorCreationDialog(query: query),
    );
  }
}
