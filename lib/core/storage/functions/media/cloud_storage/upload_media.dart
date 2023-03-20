part of 'media_database_cloud_storage.dart';

Future<String?> _uploadImageFireStore({
  required Uint8List data,
  required String path,
  Function(String? url)? onSuccess,
  Function(String? error)? onError,
}) async {
  String? url;
  try {
    final ref = MediaDatabaseCloudStorage.getReference().child(path);
    await ref.putData(data).then((value) async {
      url = await ref.getDownloadURL();
      if (onSuccess != null) {
        onSuccess(url);
      }
    });
    // final url = await ref.getDownloadURL();
    return url;
  } catch (e) {
    debugPrint("Image error: $e");
    if (onError != null) {
      onError(e.toString());
    }
    return null;
  }
}
