import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/features/books/screens/book_editor/authors_search_screen.dart';

/// Delegate that builds the search page for authors.
class AuthorsSearchDelegate extends SearchDelegate<Author?> {
  AuthorsSearchDelegate() : super(searchFieldLabel: 'Search authors');

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: Theme.of(context)
          .textTheme
          .copyWith(titleLarge: Theme.of(context).textTheme.bodyLarge),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        isDense: true,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close, size: 20),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 20),
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
