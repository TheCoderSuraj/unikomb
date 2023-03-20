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
      body: IntroductionScreen(
        rawPages: [
          Image.asset(apStart0),
          Image.asset(apStart1),
          Image.asset(apStart2),
          Image.asset(apStart3),
        ],
        // pages: [
        //   PageViewModel(
        //     // title: "Have a break, Have fun!",
        //     title:
        //         "Welcome to the community by the achievers for BELIEVERS!!!!",
        //     decoration: PageDecoration(fullScreen: true),
        //     bodyWidget: buildImage(apStart1),
        //   ),
        //   PageViewModel(
        //     // title: "Have a break, Have fun!",
        //     title: "Get Connected &\nConverse with\nExperienced Mentors!!!",
        //     reverse: true,
        //     bodyWidget: buildImage(apStart2),
        //   ),
        //   PageViewModel(
        //     // title: "Have a break, Have fun!",
        //     title: "Let us Aim for the Moon and CONQUER IT!!",
        //     bodyWidget: buildImage(apAppLogo),
        //   ),
        //   // PageViewModel(
        //   //   title: "Have a break, Have fun!",
        //   //   body:
        //   //       "You have to mange some time for yourself to make a small in your face...",
        //   //   image: buildImage(apAppLogo),
        //   // ),
        // ],
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
