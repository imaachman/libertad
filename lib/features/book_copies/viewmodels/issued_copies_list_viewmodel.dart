import 'package:libertad/data/models/book_copy.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'issued_copies_list_viewmodel.g.dart';

@riverpod
class IssuedCopiesListViewModel extends _$IssuedCopiesListViewModel {
  @override
  Future<List<BookCopy>> build() async {
    List<BookCopy> issuedCopies = [];
    // Listen for changes in book copies collection and update the state with
    // the latest data. The stream fires a snapshot immediately, so we don't
    // need to initialize data seperately. This listener handles the
    // initialization as well.
    DatabaseRepository.instance.bookCopiesStream.listen((_) async {
      // Retrieve issued copies from the database.
      issuedCopies = await DatabaseRepository.instance.getIssuedCopies();
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(issuedCopies);
    });
    return issuedCopies;
  }
}
