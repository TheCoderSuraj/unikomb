part of 'media_database_cloud_storage.dart';

Future<Uint8List?> _getImageDataFireStore(
  String path, {
  Function()? onSuccess,
  Function(String? error)? onError,
}) async {
  Uint8List? res;
  try {
    final ref = MediaDatabaseCloudStorage.getReference().child(path);
    await ref.getData().then((value) async {
      // res = await ref.getDownloadURL();
      if (value != null) {
        if (onSuccess != null) {
          onSuccess();
        }
        print("we got image data $value");
        res = value;
      }
    });
    // final url = await ref.getDownloadURL();
    return res;
  } catch (e) {
    debugPrint("Image error: $e");
    if (onError != null) {
      onError(e.toString());
    }
    return null;
  }
}
