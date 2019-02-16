import 'dart:io';
import 'package:path_provider/path_provider.dart';

enum LocalFiles { TASKS, APP_STATE }

class Storage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localTasksFile async {
    final path = await _localPath;
    return File('$path/tasks.json');
  }

  static Future<File> get _localStateFile async {
    final path = await _localPath;
    return File('$path/state.json');
  }

  static Future<File> getFileByType(LocalFiles fileType) async {
    File file;

    if (fileType == LocalFiles.TASKS) {
      file = await _localTasksFile;
    } else if (fileType == LocalFiles.APP_STATE) {
      file = await _localStateFile;
    }

    return file;
  }

  static Future<File> writeString(String string, LocalFiles fileType) async {
    final File file = await getFileByType(fileType);

    return file.writeAsString('$string');
  }

  static Future<String> readString(LocalFiles fileType) async {
    try {
      final File file = await getFileByType(fileType);

      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      return null;
    }
  }
}