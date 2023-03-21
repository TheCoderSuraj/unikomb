part of 'community_api.dart';

Stream<QuerySnapshot> _getCommunityTalk(
  String cId, {
  Function()? onSuccess,
  Function(String? error)? onError,
}) {
  return FirebaseFirestore.instance
      .collection(skCommunityDatabaseName)
      .doc(cId)
      .collection(skGeneralDiscussionCollectionName)
      .snapshots();
}

void _sendMessage(
  String cId,
  MessageModel msg, {
  Function()? onSuccess,
  Function(String? error)? onError,
}) {
  try {
    Map<String, dynamic> data = msg.toJson();
    data.remove('creationDate');
    data.remove('createdBy');
    data['createdBy'] = Auth.getCurrentUserUid();
    data['creationDAte'] = FieldValue.serverTimestamp();
    FirebaseFirestore.instance
        .collection(skCommunityDatabaseName)
        .doc(cId)
        .collection(skGeneralDiscussionCollectionName)
        .add(data);
  } catch (e) {
    debugPrint("Error $e");
  }
}
