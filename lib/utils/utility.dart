import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

String convertDateToString(DateTime d) {
  final sdf = DateFormat('dd MMM yyyy');
  return sdf.format(d);
}

/// picks image from gallery and returns it in bytes
/// and null if process cancelled
/// works with all platforms -> android, ios, web
Future<PlatformFile?> fetchImage() async {
  final res = await FilePicker.platform.pickFiles(
    type: FileType.image,
    withData: true,
  );

  if (res == null) {
    // print("User cancelled process");
    return null;
  } else {
    // print("File sizes: ${res.files.first.extension}");
    return res.files.first;
  }
}

/// to compress size of image
Future<Uint8List> compressImage(Uint8List imgBytes, {int quality = 20}) async {
  // this specific library does not work with web
  if (kIsWeb) return imgBytes;
  // later check all other libraries and go with best one
  var result = await FlutterImageCompress.compressWithList(
    imgBytes,
    quality: quality,
  );
  print("original img size ${imgBytes.length}");
  print("compressed img size ${result.length}");
  return result;
}
