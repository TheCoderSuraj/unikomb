import 'package:flutter/material.dart';

import '../../../widgets/screen_page_setup.dart';

class HomeScreen extends StatelessWidget {
  static const id = "HomeScreenId";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPageSetup(),
    );
  }
}
