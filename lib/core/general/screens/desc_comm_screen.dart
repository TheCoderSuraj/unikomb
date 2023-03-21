import 'package:flutter/material.dart';
import 'package:unikomb/core/storage/functions/community/community_api.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';

class DescCommScreen extends StatefulWidget {
  const DescCommScreen({super.key, required this.id});

  final String id;

  @override
  State<DescCommScreen> createState() => _DescCommScreenState();
}

class _DescCommScreenState extends State<DescCommScreen> {
  String value = "";
  @override
  void initState() {
    super.initState();
  }

  void getData() async {
    value = await CommunityApi.getCommunityDescription(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Description")),
      body: ScreenPageSetup(
        children: [Text(value)],
      ),
    );
  }
}
