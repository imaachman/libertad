import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'borrowers_search_viewmodel.g.dart';

@riverpod
class BorrowersSearchViewModel extends _$BorrowersSearchViewModel {
  @override
  Future<List<Borrower>> build(String query) =>
      DatabaseRepository.instance.searchBorrowers(query, active: true);
}
