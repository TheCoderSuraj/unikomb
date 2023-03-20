part of 'account_database.dart';

void _addAccountFireStore(
  AccountModel account, {
  Function()? onSuccess,
  Function(String?)? onError,
  String? uid,
}) {
  try {
    uid ??= Auth.getCurrentUserUid();
    Map<String, dynamic> data = account.toJson();
    data.remove('joiningDate');
    data['joiningDate'] = FieldValue.serverTimestamp();
    data['authUid'] = uid;
    FirebaseFirestore.instance
        .collection(skAccountDatabaseCollectionName)
        .doc(uid)
        .set(data)
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
    debugPrint("Add account error: $e ");
    if (onError != null) {
      onError(e.toString());
    }
  }
}
