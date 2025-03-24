import 'package:flutter/material.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/authors/screens/authors_screen/author_sort_dialog.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copies_sort_dialog.dart';
import 'package:libertad/features/book_copies/screens/issued_copies_screen/issued_copy_filter_dialog.dart/issued_copy_filter_dialog.dart';
import 'package:libertad/features/books/screens/book_editor/book_editor.dart';
import 'package:libertad/features/books/screens/books_screen/book_filter_dialog/book_filter_dialog.dart';
import 'package:libertad/features/books/screens/books_screen/book_sort_dialog.dart';
import 'package:libertad/features/borrowers/screens/borrower_editor/borrower_editor.dart';
import 'package:libertad/features/borrowers/screens/borrowers_screen/borrower_filter_dialog/borrower_filter_dialog.dart';
import 'package:libertad/features/borrowers/screens/borrowers_screen/borrower_sort_dialog.dart';
import 'package:libertad/features/home/screens/app_directory_dialog.dart';
import 'package:libertad/features/search/screens/database_search_delegate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

/// Business logic layer for the home page.
@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final TabController _tabController;

  @override
  void build(TabController tabController) {
    _tabController = tabController;
  }

  /// Shows the app directory dialog.
  Future<void> showDocumentsDirectory(BuildContext context) async {
    // Get paths of all the files in the directory.
    final List<String> files =
        await FilesRepository.instance.exposeAppDirectoryFiles();
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AppDirectoryDialog(files: files),
    );
  }

  /// Clears the database.
  Future<void> clearDatabase() async =>
      await DatabaseRepository.instance.clearDatabase();

  /// Resets the database to its original state with mock data.
  Future<void> resetDatabase() async =>
      await DatabaseRepository.instance.resetDatabase();

  /// Populates the database with large mock data.
  Future<void> hyperPopulateDatabase() async =>
      await DatabaseRepository.instance.hyperPopulateDatabase();

  /// Loads up the view to search the database.
  Future<void> searchDatabase(
          BuildContext context, int selectedTabIndex) async =>
      showSearch(context: context, delegate: DatabaseSearchDelegate());

  /// Shows sort dialog to select the sort type and order.
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

  /// Shows filter dialog.
  void showFilterDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          // Show filter dialog according to the current tab.
          switch (_tabController.index) {
            case 0:
              return BookFilterDialog();
            case 2:
              return IssuedCopyFilterDialog();
            case 3:
              return BorrowerFilterDialog();
            default:
              return BookFilterDialog();
          }
        },
      );

  /// Shows [BookEditor] or [BorrowerEditor] depending on the current tab.
  void showEditor({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        switch (_tabController.index) {
          case 0:
            return BookEditor();
          case 3:
            return BorrowerEditor();
          default:
            return BookEditor();
        }
      },
      isScrollControlled: true,
      showDragHandle: true,
    );
  }
}
