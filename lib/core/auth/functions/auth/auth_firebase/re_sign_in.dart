part of 'auth_firebase.dart';

void confirmIdentityWithEmailAndPasswordFirebase(
  String email,
  String password, {
  Function? onComplete,
  Function(String error)? onError,
}) async {
  AuthCredential credential =
      EmailAuthProvider.credential(email: email, password: password);
  try {
    MyFirebaseAuth.getCurrentUser()
        ?.reauthenticateWithCredential(credential)
        .then(
      (value) {
        // debugPrint("finally we have re-authenticate user.");
        debugPrint("finally we have re-authenticate user.");

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
    // if (onError != null) {
    //   onError();
    // }
    debugPrint("error re-signIn error: $e");
  }
}
