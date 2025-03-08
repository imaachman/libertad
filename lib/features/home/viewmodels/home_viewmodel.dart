import 'package:flutter/material.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/authors/screens/authors_screen/author_sort_dialog.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copies_sort_dialog.dart';
import 'package:libertad/features/books/screens/book_editor/book_editor.dart';
import 'package:libertad/features/books/screens/books_screen/book_sort_dialog.dart';
import 'package:libertad/features/borrowers/screens/borrowers_screen/borrower_sort_dialog.dart';
import 'package:libertad/features/search/screens/database_search_delegate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final TabController _tabController;

  @override
  void build(TabController tabController) {
    _tabController = tabController;
  }

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

  Future<void> searchDatabase(
          BuildContext context, int selectedTabIndex) async =>
      showSearch(context: context, delegate: DatabaseSearchDelegate());

  /// Show sort dialog to select the sort type and order.
  void showSortDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          // Show sort dialog according to the current tab.
          switch (_tabController.index) {
            case 0:
              return BookSortDialog();
            case 1:
              return AuthorSortDialog();
            case 2:
              return IssuedCopiesSortDialog();
            case 3:
              return BorrowerSortDialog();
            default:
              return BookSortDialog();
          }
        },
      );

  void showBookEditor({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BookEditor(),
      isScrollControlled: true,
      showDragHandle: true,
    );
  }
}
