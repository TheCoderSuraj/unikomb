part of 'community_api.dart';

Stream<QuerySnapshot> _getCommunityEvent(
  String cId, {
  Function()? onSuccess,
  Function(String? error)? onError,
}) {
  return FirebaseFirestore.instance
      .collection(skCommunityDatabaseName)
      .doc(cId)
      .collection(skEventCollectionName)
      .snapshots();
}

Future<void> _addCommunityEvent(
  String cId,
  EventModel data, {
  Function()? onSuccess,
  Function(String? error)? onError,
}) async {
  String res = "";
  try {
    var doc = await FirebaseFirestore.instance
        .collection(skCommunityDatabaseName)
        .doc(cId)
        .collection(skEventCollectionName)
        .add(data.toJson())
        .then((value) {
      if (onSuccess != null) {
        onSuccess();
      }
    }, onError: (e) {
      if (onError != null) {
        onError(e);
      }
    });
  } catch (e) {
    debugPrint("Error: getting desc: $e");
  }
}
