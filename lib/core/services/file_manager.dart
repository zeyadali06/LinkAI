import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  const FileManager();

  Future<String> getFullFilePath(String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid || Platform.isIOS) {
      return '${directory.path}/$fileName';
    }
    return '${directory.path}\\$fileName';
  }
}
