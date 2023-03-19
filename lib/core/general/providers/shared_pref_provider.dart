import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

class SharedPrefProvider extends ChangeNotifier {
  bool _init = false;
  bool get hasInitialized => _init;
  late SharedPreferences _pref;

  bool _firstTimeUser = true;
  bool get firstTimeUser => _firstTimeUser;

  // auth
  String _loginEmail = "";
  String get loginEmail => _loginEmail;
  String _loginPassword = "";
  String get loginPassword => _loginPassword;

  void init({Function()? onCompleted}) async {
    print("shared perf called init");
    _pref = await SharedPreferences.getInstance();

    _firstTimeUser = _pref.getBool(kFirstTimeUserPrefBoolId) ?? true;

    // auth
    _loginEmail = _pref.getString(kLoginEmailPrefStringId) ?? "";
    _loginPassword = _pref.getString(kLoginPasswordPrefStringId) ?? "";

    _init = true;
    debugPrint("shared pref all init process done");

    if (onCompleted != null) {
      onCompleted();
    }
  }

  void changeLoginEmail(String email) {
    if (!_init) {
      _notInitialized();
      return;
    }
    _pref.setString(kLoginEmailPrefStringId, email);
    _loginEmail = email;
  }

  void changeLoginPassword(String password) {
    if (!_init) {
      _notInitialized();
      return;
    }
    _pref.setString(kLoginPasswordPrefStringId, password);
    _loginPassword = password;
  }

  void updateFirstTime() {
    if (!_init) {
      _notInitialized();
      return;
    }
    _firstTimeUser = false;
    _pref.setBool(kFirstTimeUserPrefBoolId, false);
  }

  void debugReset() {
    if (!_init) {
      _notInitialized();
      return;
    }

    _pref.setBool(kFirstTimeUserPrefBoolId, true);
    _firstTimeUser = true;
    notifyListeners();
  }

  void _notInitialized() {
    debugPrint("Error: SharedPrefProvider Uninitialized Error");
    debugPrint(
        "to resolve this issue use this code before calling any method.");
    debugPrint("SharedPrefProvider.init()");
  }
}
