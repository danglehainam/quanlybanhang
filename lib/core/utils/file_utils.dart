import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileUtils {
  /// Copies a file to the Application Documents Directory for persistent storage.
  /// Returns the path of the newly saved file.
  static Future<String> saveFileToDocumentsDirectory(String originalFilePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(originalFilePath)}';
    final savedFilePath = path.join(appDir.path, fileName);
    
    final savedFile = await File(originalFilePath).copy(savedFilePath);
    return savedFile.path;
  }
}
