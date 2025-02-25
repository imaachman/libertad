import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:libertad/features/books/screens/book_editor/author_editor_dialog.dart';
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
      builder: (context) => AlertDialog(
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge,
            children: [
              TextSpan(text: 'Are you sure you want to delete author '),
              TextSpan(
                text: author.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                  text:
                      '? This will also delete all the books written by them.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await deleteAuthor(author);
              if (!context.mounted) return;
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/');
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<bool> deleteAuthor(Author author) async {
    final bool authorDeleted =
        await DatabaseRepository.instance.deleteAuthor(author);
    if (!authorDeleted) return false;
    if (author.profilePicture.isNotEmpty) {
      // Delete profile picture file only if the author was deleted succesfully.
      await FilesRepository.instance.deleteFile(author.profilePicture);
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
