import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Repository class to interact with files in the device.
class FilesRepository {
  /// Private constructor to create a singleton.
  FilesRepository._internal();

  /// We use this instance to utilize files repository.
  static final FilesRepository instance = FilesRepository._internal();

  /// Select an image file from the device.
  Future<File?> selectImageFile() async {
    // Open file picker to select an image file.
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    // If no file is selected, return.
    if (result == null) return null;
    // Create a file object from the selected file path.
    return File(result.files.single.path!);
  }

  Future<File> copyImageFile(String originalImagePath) async {
    // Get the path to the app's documents directory.
    final Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    // Path to the new image file.
    final String newImagePath =
        '${applicationDocumentsDirectory.path}/${originalImagePath.split('/').last}';
    // Copy the selected cover image to the app's documents directory.
    final File copiedFile = await File(originalImagePath).copy(newImagePath);
    return copiedFile;
  }
}
