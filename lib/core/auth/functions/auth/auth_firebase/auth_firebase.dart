import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'registration.dart';
part 'log_in.dart';
part 'manage_user.dart';
part 'phone_work.dart';
part 'email_work.dart';
part 're_sign_in.dart';

class MyFirebaseAuth {
  static FirebaseAuth? _instance;

  // basic
  static FirebaseAuth getInstance() {
    FirebaseAuth? instance = _instance;
    if (instance == null) {
      instance = FirebaseAuth.instance;
      _instance = instance;
    }

    return instance;
  }

  static User? getCurrentUser() {
    return getInstance().currentUser;
  }

  static bool checkIfUserLoggedIn() {
    if (MyFirebaseAuth.getCurrentUser() == null) {
      return false;
    } else {
      return true;
    }
  }

  static void logInUserWithEmailAndPassword(
    String email,
    String password, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    _logInUserWithEmailAndPasswordFirebase(email, password,
        onComplete: onComplete, onError: onError);
  }

  static void signOutUser({
    Function? onComplete,
    Function(String error)? onError,
  }) {
    signOutUserFirebase(
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
    registerUserWithEmailAndPasswordFirebase(email, password,
        onComplete: onComplete, onError: onError);
  }

  static confirmYourIdentity(
    String email,
    String password, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    confirmIdentityWithEmailAndPasswordFirebase(email, password,
        onComplete: onComplete, onError: onError);
  }

  // email work

  static String getUserEmailAddress() {
    return getCurrentUser()?.email ?? "";
  }

  static String getUserPhoneNumber() {
    return getCurrentUser()?.phoneNumber ?? "";
  }

  static resetUserPassword(
    String email, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    sendResetPasswordOnEmailFirebase(
      email,
      onComplete: onComplete,
      onError: onError,
    );
  }

  static bool checkIfEmailIsVerified() {
    return checkIfUserEmailIsVerifiedFirebase();
  }

  static verifyEmail() {
    sendVerificationEmailFirebase();
  }

  static updateEmailAddress(
    String newEmail, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    updateEmailAddressFirebase(newEmail,
        onComplete: onComplete, onError: onError);
  }

  static verifyPhoneNumber(
    String countryCode,
    int phoneNumber, {
    Function()? onCodeSent,
    Function()? onSuccess,
    Function(String error)? onError,
  }) {
    verifyPhoneNumberFirebase(
      countryCode,
      phoneNumber,
      onCodeSent: onCodeSent,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  static Future<bool> logInViaPhoneNumber(
    String otpCode, {
    Function? onComplete,
    Function(String error)? onError,
  }) async {
    return await _logInViaPhoneNumberFirebase(otpCode,
        onComplete: onComplete, onError: onError);
  }

  static linkPhoneNumber(
    String otpCode, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    linkPhoneNumberFirebase(otpCode, onComplete: onComplete, onError: onError);
  }

  static updatePhoneNumber(
    String otpCode, {
    Function? onComplete,
    Function(String error)? onError,
  }) {
    updatePhoneNumberFirebase(otpCode,
        onComplete: onComplete, onError: onError);
  }

  static void deleteUser({
    Function? onComplete,
    Function(String error)? onError,
  }) async {
    deleteUserFirebase(onComplete: onComplete, onError: onError);
  }
}
