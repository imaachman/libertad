import 'package:flutter/material.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/borrowers_search_screen.dart';

/// Delegate that builds the search page for borrowers.
class BorrowersSearchDelegate extends SearchDelegate<Borrower?> {
  BorrowersSearchDelegate() : super(searchFieldLabel: 'Search borrowers');

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
    return BorrowersSearchPage(query: query, close: close);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BorrowersSearchPage(query: query, close: close);
  }
}
