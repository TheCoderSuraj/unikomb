part of 'auth_firebase.dart';

String _verificationId = "";
void verifyPhoneNumberFirebase(
  String countryCode,
  int phoneNumber, {
  Function()? onCodeSent,
  Function()? onSuccess,
  Function(String error)? onError,
}) async {
  try {
    debugPrint("we got $countryCode $phoneNumber");
    await FirebaseAuth.instance
        .verifyPhoneNumber(
      // phoneNumber: '+9779848912840',
      phoneNumber: '$countryCode$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint("phone verification is completed");
        if (onSuccess != null) {
          onSuccess();
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint("phone verification is failed ${e.code} ${e.message}");
        if (onError != null) {
          onError(e.code);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint("otp code is sent");
        if (onCodeSent != null) {
          onCodeSent();
        }
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint("time out");
      },
      timeout: const Duration(seconds: 120),
    )
        .then(
      (value) {
        debugPrint("successfully verified phone number");
      },
      onError: (e) {
        if (onError != null) {
          onError(e.code);
        }
      },
    );
  } catch (e) {
    debugPrint("error on verifying phone work");
  }
}

Future<bool> _logInViaPhoneNumberFirebase(
  String otpCode, {
  Function? onComplete,
  Function(String error)? onError,
}) async {
  bool result = false;
  try {
    final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otpCode);

    await MyFirebaseAuth.getInstance().signInWithCredential(credential).then(
        (value) {
      debugPrint("phone log in success");
      if (onComplete != null) {
        onComplete();
      }
      result = true;
    }, onError: (e) {
      debugPrint("error on phone sign in: $e");
      if (onError != null) {
        onError(e.code);
      }
      result = false;
    });
  } catch (e) {
    debugPrint("error on phone sign in: $e");
    result = false;
  }
  return result;
}

linkPhoneNumberFirebase(
  String otpCode, {
  Function? onComplete,
  Function(String error)? onError,
}) async {
  try {
    final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otpCode);

    await MyFirebaseAuth.getCurrentUser()?.linkWithCredential(credential).then(
      (value) {
        debugPrint("phone log in success");
        if (onComplete != null) {
          onComplete();
        }
      },
      onError: (e) {
        if (onError != null) {
          onError(e.code);
        }
      },
    );
  } catch (e) {
    debugPrint("error on phone sign in: $e");
  }
}

updatePhoneNumberFirebase(
  String otpCode, {
  Function? onComplete,
  Function(String error)? onError,
}) async {
  try {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otpCode);

    await MyFirebaseAuth.getCurrentUser()?.updatePhoneNumber(credential).then(
        (value) {
      debugPrint("phone log in success");
      if (onComplete != null) {
        onComplete();
      }
    }, onError: (e) {
      debugPrint("error on phone sign in: $e");
      if (onError != null) {
        onError(e.code);
      }
    });
  } catch (e) {
    debugPrint("error on phone sign in: $e");
  }
}
