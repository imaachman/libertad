import 'dart:io';

import 'package:flutter/material.dart';
import 'package:libertad/data/models/author.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'author_editor_viewmodel.g.dart';

@riverpod
class AuthorEditorViewModel extends _$AuthorEditorViewModel {
  /// Name of the author.
  String name = '';

  /// Biography of the author.
  String bio = '';

  /// Path to the profile picture of the author.
  String profilePicture = '';

  /// Temporary path to the profile picture of the author. This is used to
  /// display the profile picture before the author is added to the database.
  String temporaryProfilePicture = '';

  @override
  Author? build(Author? author) {
    if (author != null) {
      name = author.name;
      bio = author.bio;
      profilePicture = author.profilePicture;
      // [temporaryProfilePicture] is used to display the profile picture in the
      // editor, and to check if it has been changed.
      temporaryProfilePicture = profilePicture;
    }
    return author;
  }

  Future<void> updateAuthor(BuildContext context) async {
    // Author must have a name and bio.
    if (name.isEmpty || bio.isEmpty) return;

    // If the profile picture has been added.
    if (temporaryProfilePicture.isNotEmpty && profilePicture.isEmpty) {
      // Copy the selected profile picture to the app's documents directory.
      final File copiedFile =
          await FilesRepository.instance.copyImageFile(temporaryProfilePicture);
      // Update the profile picture path to the new file path.
      profilePicture = copiedFile.path;
    }
    // If the profile picture has been removed.
    else if (temporaryProfilePicture.isEmpty && profilePicture.isNotEmpty) {
      // Delete the profile picture from the app's documents directory.
      await FilesRepository.instance.deleteFile(profilePicture);
      // Update the profile picture path to an empty string.
      profilePicture = '';
    }
    // If the profile picture has been changed.
    else if (temporaryProfilePicture.isNotEmpty &&
        temporaryProfilePicture != profilePicture) {
      // Replace the old profile picture with the new one.
      profilePicture = await FilesRepository.instance
          .replaceFile(profilePicture, temporaryProfilePicture);
    }
    // If author is provided, it means we are updating it.
    if (author != null) {
      // Update the author with the values from form fields.
      author!
        ..name = name
        ..bio = bio
        ..profilePicture = profilePicture;
    }
    // Context mount check to prevent memory leaks.
    if (!context.mounted) return;
    // Return the created or updated author to the previous route.
    Navigator.pop<Author>(context, author ?? Author(name: name, bio: bio));
  }

  /// Updates [name].
  void setName(String value) {
    name = value;
  }

  /// Updates [bio].
  void setBio(String value) {
    bio = value;
  }

  /// Opens file picker to select profile picture for the author.
  Future<void> selectProfilePicture() async {
    // Select an image file from the device.
    final File? file = await FilesRepository.instance.selectImageFile();
    // If no file is selected, return.
    if (file == null) return;
    // Get the path to the selected file and update [temporaryProfilePicture] to
    // display in [ProfilePicture].
    temporaryProfilePicture = file.path;
    ref.notifyListeners();
  }

  /// Clears the temporary profile picture so that the default profile picture
  /// is displayed.
  void clearProfilePicture() {
    temporaryProfilePicture = '';
    ref.notifyListeners();
  }
}
