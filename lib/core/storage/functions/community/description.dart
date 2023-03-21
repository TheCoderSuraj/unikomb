part of 'community_api.dart';

Future<String> _getCommunityDescription(
  String cId, {
  Function()? onSuccess,
  Function(String? error)? onError,
}) async {
  String res = "";
  try {
    var doc = await FirebaseFirestore.instance
        .collection(skCommunityDatabaseName)
        .doc(cId)
        .collection(skDescCollectionName)
        .doc("desc")
        .get();
    if (doc.exists && doc.data() != null) {
      res = doc.data().toString();
    }
  } catch (e) {
    debugPrint("Error: getting desc: $e");
  }
  return res;
}

Future<void> _addCommunityDescription(
  String cId,
  String value, {
  Function()? onSuccess,
  Function(String? error)? onError,
}) async {
  String res = "";
  try {
    var doc = await FirebaseFirestore.instance
        .collection(skCommunityDatabaseName)
        .doc(cId)
        .collection(skDescCollectionName)
        .doc("desc")
        .set({"body": value});
  } catch (e) {
    debugPrint("Error: getting desc: $e");
  }
}
