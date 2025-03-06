import 'package:libertad/data/models/search_result.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_search_viewmodel.g.dart';

@riverpod
class DatabaseSearchViewModel extends _$DatabaseSearchViewModel {
  int? selectedTabIndex;

  @override
  Future<SearchResult> build(String query) =>
      DatabaseRepository.instance.searchDatabase(query);
}
