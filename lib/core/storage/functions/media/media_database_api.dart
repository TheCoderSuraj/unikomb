import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'cloud_storage/media_database_cloud_storage.dart';

class MediaDatabaseApi {
  static Future<String?> uploadImage({
    required Uint8List data,
    required String path,
    Function(String? url)? onSuccess,
    Function(String? error)? onError,
  }) async {
    return MediaDatabaseCloudStorage.uploadImage(
      data: data,
      path: path,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  static Reference getReference() {
    return MediaDatabaseCloudStorage.getReference();
  }

  static Future<Uint8List?> getImageData(
    String path, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    return MediaDatabaseCloudStorage.getImageData(path,
        onError: onError, onSuccess: onSuccess);
  }

  static void updateImageData(
    String path,
    Uint8List imgBytes, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    MediaDatabaseCloudStorage.updateImageData(
      path,
      imgBytes,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  // static void downloadFile(String url) {
  //   FirebaseStorage.instance.ref()
  // }
}
