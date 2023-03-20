part of 'account_database.dart';

void _updateAccountFireStore(
  String docId,
  Map<String, dynamic> accountData, {
  Function()? onSuccess,
  Function(String?)? onError,
}) {
  try {
    FirebaseFirestore.instance
        .collection(skAccountDatabaseCollectionName)
        .doc(docId)
        .update(accountData)
        .then((value) {
      if (onSuccess != null) {
        onSuccess();
      }
    }, onError: (e) {
      if (onError != null) {
        onError(e.toString());
      }
    });
  } catch (e) {
    debugPrint("update account error: $e ");
    if (onError != null) {
      onError(e.toString());
    }
  }
}
