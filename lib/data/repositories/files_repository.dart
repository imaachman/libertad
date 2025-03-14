import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:libertad/data/models/image_folder.dart';
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

  Future<File> copyImageFile(
      String originalImagePath, ImageFolder folder) async {
    // Get the path to the app's documents directory.
    final Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    // Create app's image directory if it doesn't already exist.
    final Directory appImageDirectory = await Directory(
            '${applicationDocumentsDirectory.path}/Libertad/${folder.prettify}')
        .create(recursive: true);
    // Path to the new image file.
    final String newImagePath =
        '${appImageDirectory.path}/${originalImagePath.split('\\').last}';
    // Copy the selected image to the app's documents directory.
    final File copiedFile = await File(originalImagePath).copy(newImagePath);
    return copiedFile;
  }

  /// Delete the file from the app's documents directory.
  Future<void> deleteFile(String path) => File(path).delete();

  Future<void> deleteImageFolder(ImageFolder folder) async {
    // Get the path to the app's documents directory.
    final Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    // Create app's image directory if it doesn't already exist.
    final Directory appImageDirectory = await Directory(
            '${applicationDocumentsDirectory.path}/Libertad/${folder.prettify}')
        .create(recursive: true);
    File(appImageDirectory.path).delete(recursive: true);
  }

  /// Replace the old file with the new file.
  Future<String> replaceFile(
      String oldPath, String newPath, ImageFolder folder) async {
    // Delete the old file.
    await deleteFile(oldPath);
    // Create a copy of the new file.
    final File copiedFile = await copyImageFile(newPath, folder);
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
