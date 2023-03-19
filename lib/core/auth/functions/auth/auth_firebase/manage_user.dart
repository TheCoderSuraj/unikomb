part of 'auth_firebase.dart';

// Future<String> resetPasswordFirebase()async {}

void signOutUserFirebase({
  Function? onComplete,
  Function(String error)? onError,
}) async {
  try {
    await FirebaseAuth.instance.signOut().then(
      (value) {
        debugPrint("user sign out successfully");
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
    debugPrint("error signOut: $e");
  }
}

void deleteUserFirebase({
  Function? onComplete,
  Function(String error)? onError,
}) async {
  try {
    await MyFirebaseAuth.getCurrentUser()?.delete().then((value) {
      debugPrint("we have successfully deleted user account...");
      if (onComplete != null) {
        onComplete();
      }
    }, onError: (e) {
      debugPrint("error: deleting user -- $e");
      if (onError != null) {
        onError(e.code);
      }
    });
  } catch (e) {
    debugPrint("error on deleting user...");
  }
}
