import 'package:flutter/material.dart';
// import 'package:libertad/data/mock/mock_books.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/features/books/screens/book_list_tile.dart';

import '../../../data/models/book.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    populateBooks();
  }

  Future<void> populateBooks() async {
    books = await DatabaseRepository.instance.getAllBooks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) return Container();
    return ListView.separated(
      itemCount: books.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return BookListTile(
          book: books[index],
          index: index,
        );
      },
    );
  }
}
