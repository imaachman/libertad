import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../screens/book_editor/author_search_delegate.dart';

part 'author_field_viewmodel.g.dart';

@riverpod
class AuthorFieldViewModel extends _$AuthorFieldViewModel {
  @override
  Future<Author?> build() async => null;

  Future<void> showAuthorsSearchView(BuildContext context) async {
    final Author? result = await showSearch<Author?>(
      context: context,
      delegate: AuthorsSearchDelegate(),
    );
    if (result != null) state = AsyncData(result);
  }
}
