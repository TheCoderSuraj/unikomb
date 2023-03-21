part of 'community_api.dart';

Future<CommunityModel?> _getCommunity(String id) async {
  CommunityModel? cm;
  try {
    var v = await FirebaseFirestore.instance
        .collection(skCommunityDatabaseName)
        .doc(id)
        .get();

    if (v.exists && v.data() != null) {
      cm = CommunityModel.fromJson(v.data()!);
    }
  } catch (e) {
    debugPrint("error: $e");
  }
  return cm;
}
