import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/screens/book_editor/authors_search_screen.dart';

class AuthorsSearchDelegate extends SearchDelegate<Author?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return AuthorsSearchPage(query: query, close: close);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return AuthorsSearchPage(query: query, close: close);
  }
}
