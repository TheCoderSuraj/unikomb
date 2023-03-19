part of 'auth_firebase.dart';

void sendResetPasswordOnEmailFirebase(
  String email, {
  Function? onComplete,
  Function? onError,
}) async {
  try {
    await MyFirebaseAuth.getInstance()
        .sendPasswordResetEmail(email: email)
        .then(
      (value) {
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
    debugPrint("error reset password: $e");
  }
}

bool checkIfUserEmailIsVerifiedFirebase() {
  return MyFirebaseAuth.getCurrentUser()?.emailVerified ?? false;
}

void sendVerificationEmailFirebase() async {
  try {
    await MyFirebaseAuth.getCurrentUser()?.sendEmailVerification();
  } catch (e) {
    debugPrint("error email verification:- $e");
  }
}

void updateEmailAddressFirebase(
  String newEmail, {
  Function? onComplete,
  Function? onError,
}) async {
  try {
    await MyFirebaseAuth.getCurrentUser()?.updateEmail(newEmail).then((value) {
      debugPrint("successfully updated email address");
      if (onComplete != null) {
        onComplete();
      }
    }, onError: (e) {
      debugPrint("error - update email : $e");
    });
  } catch (e) {
    debugPrint("error reset password: $e");
  }
}
