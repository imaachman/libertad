import 'package:flutter/material.dart';
import 'package:libertad/features/search/screens/database_search_screen.dart';

/// Delegate that builds the search page for the entire database.
class DatabaseSearchDelegate extends SearchDelegate {
  DatabaseSearchDelegate() : super(searchFieldLabel: 'Search database');

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
    return DatabaseSearchPage(query: query, close: close);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return DatabaseSearchPage(query: query, close: close);
  }
}
