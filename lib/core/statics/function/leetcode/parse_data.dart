part of 'leetcode_api.dart';

Future<List<int>> _getTotalSolvedAndRankingLeetCode(String username) async {
  var v = json.decode(await _getLeetCodeData(username));
  List<int> res = [];
  res.add(v['totalSolved']);
  res.add(v['ranking']);
  return res;
}
