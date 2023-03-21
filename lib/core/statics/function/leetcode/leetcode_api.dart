import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

part 'get_data.dart';
part 'parse_data.dart';

const _baseUrl = "https://leetcode-stats-api.herokuapp.com/";

class LeetcodeApi {
  static Future<String> getData(String username) async {
    return _getLeetCodeData(username);
  }

  /// this will return list of int of length 2
  /// 1st element `totalSolved`
  /// 2nd element `ranking`
  static Future<List<int>> getTotalSolvedAndRankingLeetCode(
      String username) async {
    return _getTotalSolvedAndRankingLeetCode(username);
  }
}
