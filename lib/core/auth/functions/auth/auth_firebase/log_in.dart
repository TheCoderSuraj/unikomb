part of 'auth_firebase.dart';

void _logInUserWithEmailAndPasswordFirebase(
  String email,
  String password, {
  Function? onComplete,
  Function(String error)? onError,
}) async {
  try {
    MyFirebaseAuth.getInstance()
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        debugPrint("finally sign with email complete -- $value");
        if (onComplete != null) {
          onComplete();
        }
      },
      onError: (e) {
        debugPrint("error: failed to sign in with email -- $e");
        if (onError != null) {
          onError(e.code);
        }
      },
    );
  } on FirebaseAuthException catch (e) {
    if (onError != null) {
      onError(e.code);
    }
    if (e.code == 'user-not-found') {
      debugPrint('error - sign: No user found for that email.');
    } else if (e.code == 'wrong-password') {
      debugPrint('error - sign: Wrong password provided for that user.');
    }
  } catch (e) {
    debugPrint("error: email sign in error -- $e");
  }
}
