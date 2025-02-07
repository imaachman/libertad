import 'package:flutter/material.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/features/books/screens/book_editor/book_editor.dart';
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

  void showBookEditor({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BookEditor(),
      isScrollControlled: true,
      showDragHandle: true,
    );
  }
}
