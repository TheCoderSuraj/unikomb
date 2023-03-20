import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../../utils/asset_path.dart';
import '../../../widgets/screen_page_setup.dart';
import '../../../widgets/spinning_widget.dart';
import '../../auth/functions/auth/auth.dart';
import '../../auth/screens/login_screen.dart';
import '../providers/shared_pref_provider.dart';
import 'home_screen.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const id = "SplashScreenId";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      // will show something if first time android/ios app installed
      if (context.read<SharedPrefProvider>().firstTimeUser && !kIsWeb) {
        Navigator.pushNamedAndRemoveUntil(
            context, OnBoardingScreen.id, (route) => false);
      } else {
        // todo : uncomment below and remove temp code

        // go to home if user logged in otherwise login screen
        if (Auth.checkIfUserLoggedIn()) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.id, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.id,
            (r) => false,
          );
        }

        // temp code
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   LoginScreen.id,
        //   (r) => false,
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPageSetup(
        children: [
          const Spacer(),
          Center(
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.lightBlueAccent[100],
              child: Image.asset(
                apAppLogo,
                width: 150,
              ),
            ),
            // child: Text("Loading..."),
          ),
          const Spacer(),
          const SpinningWidget(),
          const Spacer(),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}
