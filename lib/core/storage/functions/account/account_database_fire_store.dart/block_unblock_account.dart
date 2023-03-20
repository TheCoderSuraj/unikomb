part of 'account_database.dart';

void _blockUnblockAccountFireStore(
  String uid,
  bool isBlocked, {
  Function()? onSuccess,
  Function(String?)? onError,
}) {
  try {
    FirebaseFirestore.instance
        .collection(skAccountDatabaseCollectionName)
        .doc(uid)
        .update({"isBlocked": isBlocked}).then((value) {
      if (onSuccess != null) {
        onSuccess();
      }
    }, onError: (e) {
      if (onError != null) {
        onError(e.toString());
      }
    });
  } catch (e) {
    debugPrint("block/unblock account error: $e ");
    if (onError != null) {
      onError(e.toString());
    }
  }
}
