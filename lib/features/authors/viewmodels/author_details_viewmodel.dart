import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/authors/screens/author_details_screen/author_deletion_dialog.dart';
import 'package:libertad/features/authors/screens/author_editor/author_editor_dialog.dart';
import 'package:libertad/navigation/routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'author_details_viewmodel.g.dart';

@riverpod
class AuthorDetailsViewModel extends _$AuthorDetailsViewModel {
  @override
  Author build(Author author) {
    DatabaseRepository.instance
        .authorStream(author.id)
        .listen((_) => ref.notifyListeners());
    DatabaseRepository.instance.booksStream
        .listen((_) => ref.notifyListeners());
    return author;
  }

  Future<void> showDeletionDialog(BuildContext context) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AuthorDeletionDialog(
        author: author,
        onDelete: () => deleteAuthor(context),
      ),
    );
  }

  Future<bool> deleteAuthor(BuildContext context) async {
    final bool authorDeleted =
        await DatabaseRepository.instance.deleteAuthor(author);
    if (!authorDeleted) return false;

    if (author.profilePicture.isNotEmpty) {
      // Delete profile picture file only if the author was deleted succesfully.
      await FilesRepository.instance.deleteFile(author.profilePicture);
    }

    if (context.mounted) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name == Routes.home);
    }
    return authorDeleted;
  }

  Future<void> showAuthorEditorDialog(BuildContext context) async {
    final Author? result = await showDialog(
      context: context,
      builder: (context) => AuthorEditorDialog(author: author),
    );
    if (result != null) {
      await DatabaseRepository.instance.updateAuthor(result);
    }
  }
}
