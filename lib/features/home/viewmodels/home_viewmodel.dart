import 'package:flutter/material.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/books/screens/book_editor/book_editor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  void build() {}

  Future<void> showDocumentsDirectory(BuildContext context) async {
    final List<String> files =
        await FilesRepository.instance.exposeAppDirectoryFiles();
    if (!context.mounted) return;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Files',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.separated(
                itemCount: files.length,
                itemBuilder: (context, index) => Text(
                  files[index],
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'))
            ],
          );
        });
  }

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
