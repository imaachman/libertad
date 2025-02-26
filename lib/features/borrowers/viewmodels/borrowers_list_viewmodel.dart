import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'borrowers_list_viewmodel.g.dart';

@riverpod
class BorrowersListViewModel extends _$BorrowersListViewModel {
  @override
  Future<List<Borrower>> build() async {
    List<Borrower> borrowers = [];
    // Listen for changes in borrowers collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.borrowersStream.listen((_) async {
      // Retrieve all borrowers from the database.
      borrowers = await DatabaseRepository.instance.getAllBorrowers();
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(borrowers);
    });
    return borrowers;
  }
}
