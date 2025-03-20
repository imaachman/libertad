import 'package:libertad/data/models/search_result.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_search_viewmodel.g.dart';

/// Business logic layer for database search page.
@riverpod
class DatabaseSearchViewModel extends _$DatabaseSearchViewModel {
  int? selectedTabIndex;

  /// Search through the database.
  @override
  Future<SearchResult> build(String query) =>
      DatabaseRepository.instance.searchDatabase(query);
}
