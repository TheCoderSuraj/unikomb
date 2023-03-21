part of 'community_api.dart';

void _addCommunityFireStore(
  CommunityModel cm, {
  Function()? onSuccess,
  Function(String?)? onError,
}) {
  try {
    Map<String, dynamic> data = cm.toJson();
    data.remove('joiningDate');
    data.remove('createdBy');
    data['createdBy'] = Auth.getCurrentUserUid();
    data['joiningDate'] = FieldValue.serverTimestamp();
    var doc =
        FirebaseFirestore.instance.collection(skCommunityDatabaseName).doc();
    data['id'] = doc.id;
    doc.set(data).then((value) {
      print("we got it created");
      if (onSuccess != null) {
        onSuccess();
      }
    }, onError: (e) {
      print("Error: $e");
      if (onError != null) {
        onError(e.toString());
      }
    });
  } catch (e) {
    debugPrint("error on adding community  $e");
    if (onError != null) {
      onError(e.toString());
    }
  }
}

void _addMemberInGroup(
  String mId,
  String dId, {
  Function()? onSuccess,
  Function(String?)? onError,
}) {
  try {
    var doc =
        FirebaseFirestore.instance.collection(skCommunityDatabaseName).doc(dId);
    doc.set({
      "members": FieldValue.arrayUnion([mId])
    }).then((value) {
      if (onSuccess != null) {
        onSuccess();
      }
    }, onError: (e) {
      if (onError != null) {
        onError(e);
      }
    });
  } catch (e) {
    debugPrint("Error: $e");
    if (onError != null) {
      onError(e.toString());
    }
  }
}

void _removeMemberInGroup(
  String mId,
  String dId, {
  Function()? onSuccess,
  Function(String?)? onError,
}) {
  try {
    var doc =
        FirebaseFirestore.instance.collection(skCommunityDatabaseName).doc(dId);
    doc.set({
      "members": FieldValue.arrayRemove([mId])
    }).then((value) {
      if (onSuccess != null) {
        onSuccess();
      }
    }, onError: (e) {
      if (onError != null) {
        onError(e);
      }
    });
  } catch (e) {
    debugPrint("Error: $e");
    if (onError != null) {
      onError(e.toString());
    }
  }
}
