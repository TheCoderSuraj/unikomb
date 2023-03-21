import 'package:flutter/material.dart';

import '../../../utils/common_method_widgets.dart';

class SettingsScreen extends StatelessWidget {
  static const id = "Settings Screen Id";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Screen"),
        actions: [
          getSignOutButton(context),
        ],
      ),
    );
  }
}
