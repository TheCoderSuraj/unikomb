import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/common_method_widgets.dart';
import '../../../utils/constants.dart';
import '../../../widgets/action_button.dart';
import '../../general/screens/home_screen.dart';
import '../functions/auth/auth.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const id = "EmailVerificationScreenId";
  const EmailVerificationScreen({super.key, required this.email});

  final String email;
  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isMailSent = false;
  Timer? timer;

  @override
  void dispose() {
    if (timer != null) {
      timer?.cancel();
      timer == null;
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _sendVerificationMail() {
    Auth.verifyEmailAddress();
    setState(() {
      isMailSent = true;
    });

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      Auth.reloadCurrentUser();
      if (Auth.checkIfEmailIsVerified()) {
        // goForInitialNavigation(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.id,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     buildBackButton(context),
            //     getSignOutButton(context),
            //   ],
            // ),
            Align(
              alignment: Alignment.topRight,
              child: getSignOutButton(context),
            ),
            const SizedBox(height: 80),
            const Text(
              "Email Verification",
              style: kTitleTextStyle,
            ),
            const Spacer(),
            Padding(
              padding: kAuthPagePadding,
              child: Text(
                isMailSent
                    ? "We have sent verification mail to '${widget.email}.\nAlso check spam section.'"
                    : "ou have to verify email before using application. '${widget.email}'\nIf verified just wait few seconds...",
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            if (!isMailSent)
              ActionButton(
                title: "Verify",
                onPressed: () {
                  // //TODO: logic to send verification mail

                  _sendVerificationMail();

                  // // temporary
                  // Future.delayed(Duration(seconds: 2), () {
                  //   Navigator.pushNamedAndRemoveUntil(
                  //       context, HomeScreen.id, (route) => false);
                  // });

                  // below part will be executed if mail successfully sent
                  setState(() {
                    isMailSent = true;
                  });
                },
              ),
            const Spacer(),
            // const AuthBottomWidget(),
          ],
        ),
      ),
    );
  }
}
