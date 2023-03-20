part of 'account_database.dart';

Future<AccountModel?> _getAccountFireStore(
  String uid, {
  Function(AccountModel account)? onSuccess,
  Function(String? error)? onError,
}) async {
  print("uid is $uid");

  AccountModel? res;
  try {
    await FirebaseFirestore.instance
        .collection(skAccountDatabaseCollectionName)
        .doc(uid)
        .get()
        .then((value) {
      // res = value.exists;
      if (value.data() != null) {
        res = AccountModel.fromJson(value.data()!);
        if (onSuccess != null) {
          onSuccess(res!);
        }
      }
    }, onError: (e) {
      if (onError != null) {
        onError(e.toString());
      }
    });
  } catch (e) {
    debugPrint("get account error: $e ");
    res = null;
    if (onError != null) {
      onError(e.toString());
    }
  }
  return res;
}

Future<List<AccountModel>> _getAllAccountFireStore({
  Function()? onSuccess,
  Function(String? error)? onError,
}) async {
  List<AccountModel> res = [];
  try {
    await FirebaseFirestore.instance
        .collection(skAccountDatabaseCollectionName)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        AccountModel ac = AccountModel.fromJson(doc.data());
        res.add(ac);
      }
      // res = value.exists;
      if (onSuccess != null) {
        onSuccess();
      }
      // if (value.data() != null) {
      // }
    }, onError: (e) {
      if (onError != null) {
        onError(e.toString());
      }
    });
  } catch (e) {
    debugPrint("get account error: $e ");
    // res = null;
    if (onError != null) {
      onError(e.toString());
    }
  }
  return res;
}

Future<List<AccountModel>> _getAllBlockedAccountFireStore({
  Function()? onSuccess,
  Function(String? error)? onError,
}) async {
  List<AccountModel> res = [];
  try {
    await FirebaseFirestore.instance
        .collection(skAccountDatabaseCollectionName)
        .where("isBlocked", isEqualTo: true)
        .limit(50)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        AccountModel ac = AccountModel.fromJson(doc.data());
        res.add(ac);
      }
      // res = value.exists;
      if (onSuccess != null) {
        onSuccess();
      }
      // if (value.data() != null) {
      // }
    }, onError: (e) {
      if (onError != null) {
        onError(e.toString());
      }
    });
  } catch (e) {
    debugPrint("get account error: $e ");
    // res = null;
    if (onError != null) {
      onError(e.toString());
    }
  }
  return res;
}
