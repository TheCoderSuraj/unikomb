import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/enums.dart';
import '../../../../../utils/utility.dart';
import '../../../../auth/functions/auth/auth.dart';
import '../../../../auth/models/account_model.dart';
import '../../../storage_constants.dart';

part 'add_account.dart';
part 'get_account.dart';
part 'block_unblock_account.dart';
part 'check_account.dart';
part 'update_account.dart';

class AccountDatabaseFireStore {
  static void addAccount(
    AccountModel account, {
    Function()? onSuccess,
    Function(String?)? onError,
    String? uid,
  }) {
    _addAccountFireStore(
      account,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  static void updateAccount(
    String docId,
    Map<String, dynamic> accountData, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) {
    _updateAccountFireStore(
      docId,
      accountData,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  static void blockUnblockAccount(
    String uid,
    bool isBlocked, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) {
    _blockUnblockAccountFireStore(
      uid,
      isBlocked,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  static Future<bool> checkIfAccountExists(
    String uid, {
    Function()? onSuccess,
    Function(String?)? onError,
  }) async {
    return _checkIfAccountExistsFireStore(
      uid,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  static Future<AccountModel?> getAccount(
    String uid, {
    Function(AccountModel account)? onSuccess,
    Function(String? error)? onError,
  }) async {
    return _getAccountFireStore(
      uid,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  static Future<List<AccountModel>> getAllAccount({
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    return _getAllAccountFireStore(
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  static Future<List<AccountModel>> getAllBlockedAccount({
    Function()? onSuccess,
    Function(String? error)? onError,
  }) async {
    return _getAllBlockedAccountFireStore(
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
