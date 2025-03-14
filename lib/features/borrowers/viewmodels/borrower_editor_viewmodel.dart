import 'dart:io';

import 'package:flutter/material.dart';
import 'package:libertad/data/models/borrower.dart';
import 'package:libertad/data/models/image_folder.dart';
import 'package:libertad/data/repositories/database_repository.dart';
import 'package:libertad/data/repositories/files_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'borrower_editor_viewmodel.g.dart';

@riverpod
class BorrowerEditorViewModel extends _$BorrowerEditorViewModel {
  /// Name of the borrower.
  String name = '';

  /// Contact of the borrower.
  String contact = '';

  /// Profile picture of the borrower.
  String profilePicture = '';

  /// Start date of the membership.
  DateTime membershipStartDate = DateTime(2000, 11, 5);

  /// Duration of the membership.
  int membershipDuration = 1;

  /// Temporary path to the profile picture of the borrower. This is used to
  /// display the picture before the borrower is added/updated in the database.
  String temporaryProfilePicture = '';

  @override
  Borrower? build({Borrower? borrower}) {
    if (borrower != null) {
      name = borrower.name;
      contact = borrower.contact;
      profilePicture = borrower.profilePicture;
      // [temporaryProfilePicture] is used to display the profile picture in the
      // editor, and to check if it has been changed.
      temporaryProfilePicture = profilePicture;
      membershipStartDate = borrower.membershipStartDate;
      membershipDuration = borrower.membershipDuration;
    }
    return borrower;
  }

  /// Creates a [Borrower] object from the form fields' values and adds it to
  /// the database.
  Future<void> addBorrower(
      BuildContext context, GlobalKey<FormState> formKey) async {
    // If any of the inputs are invalid, do not add the book to the database.
    if (!formKey.currentState!.validate()) return;

    // If a profile picture has been selected, copy it to the app's documents
    // directory and update [profilePicture] with the new path.
    if (temporaryProfilePicture.isNotEmpty) {
      final File copiedFile = await FilesRepository.instance.copyImageFile(
          temporaryProfilePicture, ImageFolder.borrowerProfilePictures);
      // Update the profile picture path to the new file path.
      profilePicture = copiedFile.path;
    }

    // Create a new [Borrower] object with the values of form fields.
    final Borrower newBorrower = Borrower(
      name: name,
      contact: contact,
      profilePicture: profilePicture,
      membershipStartDate: membershipStartDate,
      membershipDuration: membershipDuration,
    );

    // Add the borrower to the database.
    await DatabaseRepository.instance.addBorrower(newBorrower);

    // Context mount check to prevent memory leaks.
    if (!context.mounted) return;
    // Navigate back from the borrower editor.
    Navigator.of(context).pop();
  }

  Future<void> updateBorrower(BuildContext context,
      GlobalKey<FormState> formKey, Borrower borrower) async {
    // If any of the inputs are invalid, do not update the borrower in the
    // database.
    if (!formKey.currentState!.validate()) return;

    // If the profile picture has been added.
    if (temporaryProfilePicture.isNotEmpty && profilePicture.isEmpty) {
      // Copy the selected profile picture to the app's documents directory.
      final File copiedFile = await FilesRepository.instance.copyImageFile(
          temporaryProfilePicture, ImageFolder.borrowerProfilePictures);
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
      profilePicture = await FilesRepository.instance.replaceFile(
        profilePicture,
        temporaryProfilePicture,
        ImageFolder.borrowerProfilePictures,
      );
    }

    // Update the existing [Borrower] object with the values of form fields.
    borrower
      ..name = name
      ..contact = contact
      ..profilePicture = profilePicture
      ..membershipStartDate = membershipStartDate
      ..membershipDuration = membershipDuration;

    // Update the book in the database.
    await DatabaseRepository.instance.updateBorrower(borrower);

    // Context mount check to prevent memory leaks.
    if (!context.mounted) return;
    // Navigate back from the borrower editor.
    Navigator.of(context).pop();
  }

  /// Updates [name].
  void setName(String value) {
    name = value;
    ref.notifyListeners();
  }

  /// Checks if the input for borrower's name is valid.
  /// Returned string is displayed to the user as feedback.
  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter borrower\'s name';
    return null;
  }

  /// Updates [contact].
  void setContact(String value) {
    contact = value;
    ref.notifyListeners();
  }

  /// Checks if the input for borrower's contact is valid.
  /// Returned string is displayed to the user as feedback.
  String? validateContact(String? value) {
    if (value == null || value.isEmpty) return 'Please enter borrower\'s name';
    if (value.length != 10) return 'Please enter a valid phone number';
    return null;
  }

  /// Opens file picker to select a profile picture for the borrower.
  Future<void> selectProfilePicture() async {
    // Select an image file from the device.
    final File? file = await FilesRepository.instance.selectImageFile();
    // If no file is selected, return.
    if (file == null) return;
    // Get the path to the selected file and update [temporaryProfilePicture] to
    // display as profile picture.
    temporaryProfilePicture = file.path;
    ref.notifyListeners();
  }

  /// Clears the temporary profile picture so that the default profile picture
  /// is displayed.
  void clearProfilePicture() {
    temporaryProfilePicture = '';
    ref.notifyListeners();
  }

  /// Opens date picker and selects the membership start date of the borrower.
  Future<void> selectMembershipStartDate(BuildContext context) async {
    // Show date picker dialog.
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: membershipStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    // If a date is selected, update membership start date.
    if (selectedDate != null) {
      membershipStartDate = selectedDate;
      ref.notifyListeners();
    }
  }

  /// Updates [membershipDuration].
  void setMembershipDuration(String value) {
    if (value.isEmpty) return;
    membershipDuration = int.parse(value);
  }

  /// Checks if the input for membership duration is valid.
  /// Returned string is displayed to the user as feedback.
  String? validateMembershipDuration(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please add the duration of membership';
    }
    return null;
  }
}
