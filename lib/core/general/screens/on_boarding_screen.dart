import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../../utils/asset_path.dart';
import '../../../utils/constants.dart';
import '../../auth/screens/login_screen.dart';
import '../providers/shared_pref_provider.dart';

class OnBoardingScreen extends StatelessWidget {
  static const id = "OnBoardingScreenId";
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Have a break, Have fun!",
              body:
                  "You have to mange some time for yourself to make a small in your face...",
              image: buildImage(apAppLogo),
            ),
            PageViewModel(
              title: "Have a break, Have fun!",
              body:
                  "You have to mange some time for yourself to make a small in your face...",
              image: buildImage(apAppLogo),
            ),
            PageViewModel(
              title: "Have a break, Have fun!",
              body:
                  "You have to mange some time for yourself to make a small in your face...",
              image: buildImage(apAppLogo),
            ),
            PageViewModel(
              title: "Have a break, Have fun!",
              body:
                  "You have to mange some time for yourself to make a small in your face...",
              image: buildImage(apAppLogo),
            ),
          ],
          done: const Text(
            "Done",
            style: kSemiBoldTextStyle,
          ),
          onDone: () {
            context.read<SharedPrefProvider>().updateFirstTime();
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.id, (route) => false);
          },
          showSkipButton: true,
          skip: const Text(
            "Skip",
            style: kSemiBoldTextStyle,
          ),
          next: const Icon(Icons.arrow_forward_rounded),
          dotsDecorator: const DotsDecorator(
            size: Size(5, 5),
            activeSize: Size(30, 10),
            activeColor: Colors.lightBlue,
          ),
        ),
      ),
    );
  }

  Widget buildImage(String path) {
    return Padding(
      padding: kPagePadding,
      child: Center(
        child: Image.asset(path),
      ),
    );
  }
}
