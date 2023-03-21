import 'package:flutter/material.dart';
import 'package:unikomb/core/statics/function/leetcode/leetcode_api.dart';
import 'package:unikomb/widgets/designed_container.dart';

class LeetcodeShowcase extends StatefulWidget {
  const LeetcodeShowcase({
    super.key,
    required this.username,
  });
  final String username;

  @override
  State<LeetcodeShowcase> createState() => _LeetcodeShowcaseState();
}

class _LeetcodeShowcaseState extends State<LeetcodeShowcase> {
  bool isLoading = true;
  int totalSolved = 0;
  int ranking = 0;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var res =
        await LeetcodeApi.getTotalSolvedAndRankingLeetCode(widget.username);
    setState(() {
      totalSolved = res[0];
      ranking = res[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DesignedContainer(
      child: Column(
        children: [
          Text("Total solved: $totalSolved"),
          Text("Rank: $ranking"),
        ],
      ),
    );
  }
}
