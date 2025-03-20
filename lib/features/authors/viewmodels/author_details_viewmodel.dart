import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/authors/screens/author_details_screen/author_deletion_dialog.dart';
import 'package:libertad/features/authors/screens/author_editor/author_editor_dialog.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'author_details_viewmodel.g.dart';

/// Business logic layer for author details page.
@riverpod
class AuthorDetailsViewModel extends _$AuthorDetailsViewModel {
  @override
  Author build(Author author) {
    // Listen for changes to this particular author object and update the state
    // with the latest data.
    DatabaseRepository.instance
        .authorStream(author.id)
        .listen((_) => ref.notifyListeners());
    // Listen for changes in books collection and update the state with the
    // latest data.
    DatabaseRepository.instance.booksStream
        .listen((_) => ref.notifyListeners());
    return author;
  }

  /// Shows author deletion dialog.
  Future<void> showDeletionDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AuthorDeletionDialog(
        author: author,
        onDelete: () => deleteAuthor(context),
      ),
    );
  }

  /// Deletes the author from database and also its profile picture from the
  /// app directory.
  Future<bool> deleteAuthor(BuildContext context) async {
    // Delete the author from database.
    final bool authorDeleted =
        await DatabaseRepository.instance.deleteAuthor(author);
    // If author wasn't succesfully deleted, return false.
    if (!authorDeleted) return false;
    // If author had a profile picture.
    if (author.profilePicture.isNotEmpty) {
      // Delete profile picture file only if the author was deleted succesfully.
      await FilesRepository.instance.deleteFile(author.profilePicture);
    }
    // Navigate back to the home page.
    if (context.mounted) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name == Routes.home);
    }
    // Return deletion status.
    return authorDeleted;
  }

  /// Shows author editor dialog.
  Future<void> showAuthorEditorDialog(BuildContext context) async {
    final Author? result = await showDialog(
      context: context,
      builder: (context) => AuthorEditorDialog(author: author),
    );
    // If author was updated, save the changes to the database.
    if (result != null) {
      await DatabaseRepository.instance.updateAuthor(result);
    }
  }
}
