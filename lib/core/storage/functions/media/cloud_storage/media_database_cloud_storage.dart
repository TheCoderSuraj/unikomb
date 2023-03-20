import 'package:flutter/foundation.dart';

import 'package:firebase_storage/firebase_storage.dart';

part 'upload_media.dart';
part 'get_media.dart';
part 'update_image.dart';

class MediaDatabaseCloudStorage {
  static Reference getReference() {
    return FirebaseStorage.instance.ref();
  }

  static Future<String?> uploadImage({
    required Uint8List data,
    required String path,
    Function(String? url)? onSuccess,
    Function(String? error)? onError,
  }) async {
    return _uploadImageFireStore(
      data: data,
      path: path,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static Future<Uint8List?> getImageData(
    String path, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    return _getImageDataFireStore(path, onError: onError, onSuccess: onSuccess);
  }

  static void updateImageData(
    String path,
    Uint8List imgBytes, {
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    _updateImageDataFireStore(
      path,
      imgBytes,
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
