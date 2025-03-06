import 'package:flutter/material.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/features/book_copies/screens/copy_details_screen/borrowers_search_screen.dart';

class BorrowersSearchDelegate extends SearchDelegate<Borrower?> {
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
    return BorrowersSearchPage(query: query, close: close);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BorrowersSearchPage(query: query, close: close);
  }
}
