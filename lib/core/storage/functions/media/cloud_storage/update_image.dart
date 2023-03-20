part of 'media_database_cloud_storage.dart';

void _updateImageDataFireStore(
  String path,
  Uint8List imgBytes, {
  Function()? onSuccess,
  Function(String? error)? onError,
}) async {
  // Uint8List? res;
  try {
    final ref = MediaDatabaseCloudStorage.getReference().child(path);
    await ref.putData(imgBytes).then((value) async {
      // res = await ref.getDownloadURL();
      if (onSuccess != null) {
        onSuccess();
      }
    });
    // final url = await ref.getDownloadURL();
    // return res;
  } catch (e) {
    debugPrint("Image error: $e");
    if (onError != null) {
      onError(e.toString());
    }
    return null;
  }
}
