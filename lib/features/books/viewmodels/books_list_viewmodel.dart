import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/models/book_sort.dart';
import 'package:libertad/data/models/genre.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'books_list_viewmodel.g.dart';

@riverpod
class BooksListViewModel extends _$BooksListViewModel {
  SortOrder selectedSortOrder = SortOrder.ascending;
  BookSort? bookSort;

  Genre? genreFilter;

  @override
  Future<List<Book>> build() async {
    List<Book> books = [];
    // Listen for changes in books collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.booksStream.listen((_) async {
      // Retrieve all books from the database.
      books = await DatabaseRepository.instance.getAllBooks(sortBy: bookSort);
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(books);
    });
    return books;
  }

  /// Select sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sort the books according to the selected [BookSort] type.
  Future<void> sort(BookSort sortBy) async {
    // Update [bookSort] to show the selected sort type in the UI.
    bookSort = sortBy;
    // Retrieve the books again in the selected sort type and update the state.
    state = AsyncData(
      await DatabaseRepository.instance.getAllBooks(
        sortBy: bookSort,
        sortOrder: selectedSortOrder,
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }

  void selectGenreFilter(Genre genre) {
    genreFilter = genre;
    ref.notifyListeners();
  }

  void clearGenreFilter() {
    genreFilter = null;
    ref.notifyListeners();
  }
}
