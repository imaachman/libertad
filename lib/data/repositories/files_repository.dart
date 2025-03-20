import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:libertad/data/models/image_folder.dart';
import 'package:path_provider/path_provider.dart';

/// Repository of methods which we can use to interact with device files.
class FilesRepository {
  /// Private constructor to create a singleton.
  FilesRepository._internal();

  /// We use this instance to provide access to the files repository across the
  /// app.
  static final FilesRepository instance = FilesRepository._internal();

  /// Selects an image file from the device.
  Future<File?> selectImageFile() async {
    // Open file picker to select an image file.
    // We allow only `jpg`, `jpeg`, and `png` formats.
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    // If no file is selected, return.
    if (result == null) return null;
    // Create a file object from the selected file path.
    return File(result.files.single.path!);
  }

  /// Copies the image file to the app's image directory.
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
    // Copy the selected image to the app's image directory.
    final File copiedFile = await File(originalImagePath).copy(newImagePath);
    return copiedFile;
  }

  /// Deletes the file from the app directory.
  Future<void> deleteFile(String path) => File(path).delete();

  /// Deletes the image directory provided as [folder].
  Future<void> deleteImageFolder(ImageFolder folder) async {
    // Get the path to the app's documents directory.
    final Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    // Create app's image directory if it doesn't already exist.
    final Directory appImageDirectory = await Directory(
            '${applicationDocumentsDirectory.path}/Libertad/${folder.prettify}')
        .create(recursive: true);
    // Delete the image directory.
    File(appImageDirectory.path).delete(recursive: true);
  }

  /// Replaces the old file with the new file and returns the new file's path.
  Future<String> replaceFile(
      String oldPath, String newPath, ImageFolder folder) async {
    // Delete the old file.
    await deleteFile(oldPath);
    // Create a copy of the new file.
    final File copiedFile = await copyImageFile(newPath, folder);
    // Return copied file's path.
    return copiedFile.path;
  }

  /// Exposes app directory by returning the paths to all the files. (for
  /// development purposes only)
  Future<List<String>> exposeAppDirectoryFiles() async {
    // Get the path to the app's documents directory.
    final Directory applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    // Retrieve app directory by appending to the path.
    final Directory appDirectory =
        Directory('${applicationDocumentsDirectory.path}/Libertad');
    // Retrieve all files in the directory.
    final List<FileSystemEntity> files = appDirectory.listSync(recursive: true);
    // Return all files' path.
    return files.map((file) => file.path).toList();
  }
}
