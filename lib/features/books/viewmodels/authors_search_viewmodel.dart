import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authors_search_viewmodel.g.dart';

@riverpod
class AuthorsSearchViewModel extends _$AuthorsSearchViewModel {
  @override
  Future<List<Author>> build(String query) =>
      DatabaseRepository.instance.searchAuthors(query);
}
