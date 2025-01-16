import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authors_list_viewmodel.g.dart';

@riverpod
class AuthorsListViewModel extends _$AuthorsListViewModel {
  @override
  Future<List<Author>> build() async {
    List<Author> authors = [];
    // Listen for changes in authors collection and update the state with the
    // latest data. The stream fires a snapshot immediately, so we don't need
    // to initialize data seperately. This listener handles the initialization
    // as well.
    DatabaseRepository.instance.authorsStream.listen((_) async {
      // Retrieve all authors from the database.
      authors = await DatabaseRepository.instance.getAllAuthors();
      // Update state and notify listeners to rebuild the UI.
      state = AsyncData(authors);
    });
    return authors;
  }
}