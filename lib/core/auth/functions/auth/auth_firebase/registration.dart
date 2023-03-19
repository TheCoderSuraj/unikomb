part of 'auth_firebase.dart';

void registerUserWithEmailAndPasswordFirebase(
  String email,
  String password, {
  Function? onComplete,
  Function(String error)? onError,
}) async {
  try {
    await MyFirebaseAuth.getInstance()
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      debugPrint("finally registration complete -- $value");
      if (onComplete != null) {
        onComplete();
      }
    }, onError: (e) {
      debugPrint("error: registration failed to $e");
      if (onError != null) {
        onError(e.code);
      }
    });
  } on FirebaseAuthException catch (e) {
    if (onError != null) {
      onError(e.code);
    }
    if (e.code == 'weak-password') {
      debugPrint('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      debugPrint('The account already exists for that email.');
    }
  } catch (e) {
    debugPrint("error: registration error -- $e");
  }
}
