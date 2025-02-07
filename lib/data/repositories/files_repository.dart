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
    // Create book covers directory if it doesn't already exist.
    final Directory bookCoversDirectory = await Directory(
            '${applicationDocumentsDirectory.path}/Libertad/Book Covers')
        .create(recursive: true);
    // Path to the new image file.
    final String newImagePath =
        '${bookCoversDirectory.path}/${originalImagePath.split('\\').last}';
    // Copy the selected cover image to the app's documents directory.
    final File copiedFile = await File(originalImagePath).copy(newImagePath);
    return copiedFile;
  }

  /// Delete the file from the app's documents directory.
  Future<void> deleteFile(String path) => File(path).delete();

  /// Replace the old file with the new file.
  Future<String> replaceFile(String oldPath, String newPath) async {
    // Delete the old file.
    await deleteFile(oldPath);
    // Create a copy of the new file.
    final File copiedFile = await copyImageFile(newPath);
    return copiedFile.path;
  }

  Future<List<String>> exposeAppDirectoryFiles() async {
    final Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    final Directory appDirectory =
        Directory('${applicationDocumentsDirectory.path}/Libertad');
    final List<FileSystemEntity> files = appDirectory.listSync(recursive: true);
    return files.map((file) => file.path).toList();
  }
}
