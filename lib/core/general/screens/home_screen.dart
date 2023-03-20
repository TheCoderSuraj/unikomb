import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/functions/auth/auth.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/utils/common_method_widgets.dart';

import '../../../widgets/screen_page_setup.dart';

class HomeScreen extends StatelessWidget {
  static const id = "HomeScreenId";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          getSignOutButton(context),
        ],
      ),
      body: ScreenPageSetup(
        children: [
          Text("home screen"),
        ],
      ),
    );
  }
}
