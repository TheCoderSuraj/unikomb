part of 'leetcode_api.dart';

Future<String> _getLeetCodeData(String username) async {
  String res = '';
  String url = _baseUrl + username;
  try {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      res = response.body;
    }
  } catch (e) {
    res = "";
    debugPrint("Leet code error: $e");
  }
  return res;
}

Future<bool> verifyLeetcodeUsername(String username) async {
  var j = json.decode(await _getLeetCodeData(username));
  if (j['status'] == "success") return true;
  return false;
}
