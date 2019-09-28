import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> getDownloadPath() async {
  return await getSavePath("/Download/");
}

Future<String> getSavePath(String endPath) async {
  Directory tempDir = await getApplicationDocumentsDirectory();
  if (Platform.isAndroid) {
    tempDir = await getExternalStorageDirectory();
  } else if (Platform.isIOS) {
    tempDir = await getApplicationSupportDirectory();
  } else {
    //TODO
  }
  print("=======tempDir=======>${tempDir.path}");
  String path = tempDir.path + endPath;
  Directory directory = Directory(path);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }
  print("=======path=======>$path");
  return path;
}
