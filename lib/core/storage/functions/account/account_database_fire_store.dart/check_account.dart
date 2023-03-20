part of 'account_database.dart';

Future<bool> _checkIfAccountExistsFireStore(
  String uid, {
  Function()? onSuccess,
  Function(String?)? onError,
}) async {
  bool res = false;
  try {
    await FirebaseFirestore.instance
        .collection(skAccountDatabaseCollectionName)
        .doc(uid)
        .get()
        .then((value) {
      res = value.exists;
      if (onSuccess != null) {
        onSuccess();
      }
    }, onError: (e) {
      if (onError != null) {
        onError(e.toString());
      }
    });
  } catch (e) {
    debugPrint("check account exists error: $e ");
    res = false;
    if (onError != null) {
      onError(e.toString());
    }
  }
  return res;
}
