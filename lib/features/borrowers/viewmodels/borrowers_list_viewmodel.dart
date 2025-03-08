import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/borrower_sort.dart';
import 'package:libertad/data/models/sort_order.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'borrowers_list_viewmodel.g.dart';

@riverpod
class BorrowersListViewModel extends _$BorrowersListViewModel {
  SortOrder selectedSortOrder = SortOrder.ascending;
  BorrowerSort? borrowerSort;

  @override
  Future<List<Borrower>> build() async {
    List<Borrower> borrowers = [];
    // Listen for changes in borrowers collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.borrowersStream.listen((_) async {
      // Retrieve all borrowers from the database.
      borrowers = await DatabaseRepository.instance.getAllBorrowers(
        sortBy: borrowerSort,
        sortOrder: selectedSortOrder,
      );
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(borrowers);
    });
    return borrowers;
  }

  /// Select sort order -- ascending or descending.
  void selectSortOrder(SortOrder sortOrder) {
    selectedSortOrder = sortOrder;
    ref.notifyListeners();
  }

  /// Sort the books according to the selected [BorrowerSort] type.
  Future<void> sort(BorrowerSort sortBy) async {
    // Update [borrowerSort] to show the selected sort type in the UI.
    borrowerSort = sortBy;
    // Retrieve the borrowers again in the selected sort type and update the
    // state.
    state = AsyncData(
      await DatabaseRepository.instance.getAllBorrowers(
        sortBy: borrowerSort,
        sortOrder: selectedSortOrder,
      ),
    );
    // Keep provider alive to preserve the order.
    ref.keepAlive();
  }
}
