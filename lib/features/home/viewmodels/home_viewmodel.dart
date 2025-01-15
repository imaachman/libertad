import 'package:flutter/material.dart';
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

  void openAddBookBottomsheet(
      {required BuildContext context,
      required Widget Function(BuildContext context) builder}) {
    showModalBottomSheet(
      context: context,
      builder: builder,
      isScrollControlled: true,
      showDragHandle: true,
    );
  }
}
