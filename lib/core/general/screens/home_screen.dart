import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/functions/auth/auth.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';

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
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Auth.signOutUser();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.id, (route) => false);
            },
          ),
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
