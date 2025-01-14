import 'package:libertad/data/models/book.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  void build() {}

  Future<void> clearDatabase() async =>
      await DatabaseRepository.instance.clearDatabase();

  Future<void> resetDatabase() async =>
      await DatabaseRepository.instance.resetDatabase();

  void addBook(Book book) async =>
      await DatabaseRepository.instance.addBook(book);
}
