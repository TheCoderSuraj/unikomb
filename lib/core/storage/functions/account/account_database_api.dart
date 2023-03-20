import '../../../../utils/enums.dart';
import '../../../auth/models/account_model.dart';
import 'account_database_fire_store.dart/account_database.dart';

class AccountDatabaseApi {
  static void addAccount(
    AccountModel account, {
    required String uid,
    Function()? onSuccess,
    Function(String?)? onError,
  }) {
    AccountDatabaseFireStore.addAccount(
      account,
      onSuccess: onSuccess,
      onError: onError,
      uid: uid,
    );
  }

  static void updateAccount(
    String id,
    Map<String, dynamic> accountData, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) {
    AccountDatabaseFireStore.updateAccount(
      id,
      accountData,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  // static void changeAccountRole(
  //   String docId,
  //   UserRole role, {
  //   Function()? onSuccess,
  //   Function(String?)? onError,
  // }) {
  //   AccountDatabaseFireStore.changeAccountRole(
  //     docId,
  //     role,
  //     onError: onError,
  //     onSuccess: onSuccess,
  //   );
  // }

  static void blockUnblockAccount(
    String uid,
    bool isBlocked, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) {
    AccountDatabaseFireStore.blockUnblockAccount(uid, isBlocked,
        onSuccess: onSuccess, onError: onError);
  }

  static Future<bool> checkIfAccountExists(
    String uid, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) async {
    return AccountDatabaseFireStore.checkIfAccountExists(uid,
        onSuccess: onSuccess, onError: onError);
  }

  static Future<AccountModel?> getAccount(
    String uid, {
    Function(AccountModel account)? onSuccess,
    Function(String? error)? onError,
  }) async {
    return AccountDatabaseFireStore.getAccount(uid,
        onSuccess: onSuccess, onError: onError);
  }

  static Future<List<AccountModel>> getAllAccount({
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    return AccountDatabaseFireStore.getAllAccount(
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static Future<List<AccountModel>> getAllBlockedAccount({
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    return AccountDatabaseFireStore.getAllBlockedAccount(
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
