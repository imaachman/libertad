import 'package:flutter/material.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/features/books/screens/books_screen/book_sort_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'books_list_viewmodel.g.dart';

@riverpod
class BooksListViewModel extends _$BooksListViewModel {
  SortOrder selectedSortOrder = SortOrder.ascending;
  BookSort? _sortBy;

  @override
  Future<List<Book>> build() async {
    List<Book> books = [];
    // Listen for changes in books collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.booksStream.listen((_) async {
      // Retrieve all books from the database.
      books = await DatabaseRepository.instance.getAllBooks(sortBy: _sortBy);
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(books);
    });
    return books;
  }

  Future<void> showSortDialog(BuildContext context) async {
    showDialog(context: context, builder: (context) => BookSortDialog());
  }

  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  Future<void> sortBy(BookSort sortBy) async {
    _sortBy = sortBy;
    state = AsyncData(
        await DatabaseRepository.instance.getAllBooks(sortBy: _sortBy));
  }
}
