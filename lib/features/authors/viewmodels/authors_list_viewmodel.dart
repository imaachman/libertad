import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/models/author_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authors_list_viewmodel.g.dart';

/// Business logic layer for authors list page.
@riverpod
class AuthorsListViewModel extends _$AuthorsListViewModel {
  /// Order in which the sorted list should be displayed.
  SortOrder selectedSortOrder = SortOrder.ascending;

  /// Defines how the authors should be sorted.
  AuthorSort? authorSort;

  @override
  Future<List<Author>> build() async {
    List<Author> authors = [];
    // Listen for changes in authors collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.authorsStream.listen((_) async {
      // Retrieve all authors from the database.
      authors = await DatabaseRepository.instance.getAuthors(
        sortBy: authorSort,
        sortOrder: selectedSortOrder,
      );
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(authors);
    });
    return authors;
  }

  /// Selects sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sorts the authors according to the selected [AuthorSort] type.
  Future<void> sort(AuthorSort value) async {
    // Update [authorSort] to show the selected sort type in the UI.
    authorSort = value;
    // Retrieve the authors again in the selected sort type and update the
    // state.
    state = AsyncData(
      await DatabaseRepository.instance.getAuthors(
        sortBy: authorSort,
        sortOrder: selectedSortOrder,
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }
}
