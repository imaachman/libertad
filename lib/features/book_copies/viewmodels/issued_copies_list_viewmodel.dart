import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/models/issued_copy_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'issued_copies_list_viewmodel.g.dart';

@riverpod
class IssuedCopiesListViewModel extends _$IssuedCopiesListViewModel {
  SortOrder selectedSortOrder = SortOrder.ascending;
  IssuedCopySort? issuedCopySort;

  @override
  Future<List<BookCopy>> build() async {
    List<BookCopy> issuedCopies = [];
    // Listen for changes in book copies collection and update the state with
    // the latest data. The stream fires a snapshot immediately, so we don't
    // need to initialize data seperately. This listener handles the
    // initialization as well.
    DatabaseRepository.instance.bookCopiesStream.listen((_) async {
      // Retrieve issued copies from the database.
      issuedCopies = await DatabaseRepository.instance.getIssuedCopies(
        sortBy: issuedCopySort,
        sortOrder: selectedSortOrder,
      );
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(issuedCopies);
    });
    return issuedCopies;
  }

  /// Select sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sort the copies according to the selected [IssuedCopySort] type.
  Future<void> sort(IssuedCopySort sortBy) async {
    // Update [issuedCopySort] to show the selected sort type in the UI.
    issuedCopySort = sortBy;
    // Retrieve the copies again in the selected sort type and update the state.
    state = AsyncData(
      await DatabaseRepository.instance.getIssuedCopies(
        sortBy: issuedCopySort,
        sortOrder: selectedSortOrder,
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }
}
