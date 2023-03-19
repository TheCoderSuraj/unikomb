import 'package:flutter/foundation.dart';

import 'auth_firebase/auth_firebase.dart';

class Auth {
  static testCall() {
    // verifyEmailAddress();
    // print("this is test call from airtime");
  }

  static void reloadCurrentUser() {
    MyFirebaseAuth.getCurrentUser()?.reload();
  }

  static String? getCurrentUserUid() {
    return MyFirebaseAuth.getInstance().currentUser?.uid;
  }

  static bool checkIfUserLoggedIn() {
    return MyFirebaseAuth.checkIfUserLoggedIn();
  }

// login & registration
  static void signInUser(
    String email,
    String password, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    MyFirebaseAuth.logInUserWithEmailAndPassword(
      email,
      password,
      onComplete: onComplete,
      onError: onError,
    );
  }

  static signOutUser({
    Function? onComplete,
    Function(String error)? onError,
  }) {
    MyFirebaseAuth.signOutUser(
      onComplete: onComplete,
      onError: onError,
    );
  }

  static registerUser(
    String email,
    String password, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    MyFirebaseAuth.registerUser(email, password,
        onComplete: onComplete, onError: onError);
  }

  static confirmYourIdentity(
    String email,
    String password, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    MyFirebaseAuth.confirmYourIdentity(email, password,
        onComplete: onComplete, onError: onError);
  }

  static updateEmailAddress(
    String email, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    MyFirebaseAuth.updateEmailAddress(email,
        onComplete: onComplete, onError: onError);
  }

  static updatePhoneNumber(String otpValue,
      {Function? onComplete, Function(String error)? onError}) {
    MyFirebaseAuth.updatePhoneNumber(otpValue,
        onComplete: onComplete, onError: onError);
  }

  static verifyPhoneNumber(
    String countryCode,
    int phoneNumber, {
    Function()? onCodeSent,
    Function()? onSuccess,
    Function(String error)? onError,
  }) {
    MyFirebaseAuth.verifyPhoneNumber(
      countryCode,
      phoneNumber,
      onCodeSent: onCodeSent,
      onSuccess: () {
        debugPrint("success auth");
      },
      onError: onError,
    );
  }

  static Future<bool> logInViaPhoneNumber(
    String otpValue, {
    Function? onComplete,
    Function(String error)? onError,
  }) async {
    // verifyOtpLogInFirebase(otpValue, onComplete);
    return MyFirebaseAuth.logInViaPhoneNumber(otpValue,
        onComplete: onComplete, onError: onError);
  }

  static linkPhoneNumber(
    String otpValue, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    // verifyOtpLinkFirebase(otpValue, onComplete);
    MyFirebaseAuth.linkPhoneNumber(otpValue,
        onComplete: onComplete, onError: onError);
  }

// email related work

  static String getUserEmailAddress() {
    return MyFirebaseAuth.getUserEmailAddress();
  }

  static String getUserPhoneNumber() {
    return MyFirebaseAuth.getUserPhoneNumber();
  }
  // static String requiresUpdatedUserEmailAddress() {
  //   MyFirebaseAuth.requiresUpdatedUser();
  //   return getUserEmailAddress();
  // }

  static resetUserPassword(
    String email, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    MyFirebaseAuth.resetUserPassword(email,
        onComplete: onComplete, onError: onError);
    // return await resetUserPasswordFirebase(email, onComplete);
  }

  static bool checkIfEmailIsVerified() {
    return MyFirebaseAuth.checkIfEmailIsVerified();
  }

  static verifyEmailAddress() {
    MyFirebaseAuth.verifyEmail();
  }

  static void deleteUser({
    Function? onComplete,
    Function(String error)? onError,
  }) async {
    MyFirebaseAuth.deleteUser(onComplete: onComplete, onError: onError);
  }
}
