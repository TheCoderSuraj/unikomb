import 'package:flutter/material.dart';
import '../../../utils/common_method_widgets.dart';
import '../../../utils/constants.dart';
import '../../../utils/validity_methods.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/screen_page_setup.dart';
import '../functions/auth/auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const id = "ForgetPasswordScreenId";
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool isSent = false;
  TextEditingController _controller = TextEditingController();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPageSetup(
        padding: const EdgeInsets.all(0),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildBackButton(context),
          const SizedBox(height: 80),
          const Text(
            "Forget Password",
            style: kTitleTextStyle,
          ),
          Padding(
            padding: kAuthPagePadding,
            // const Spacer(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                Text(
                  isSent
                      ? "We have sent link to reset password to '$email'.\nPlease also check spam section."
                      : "Please enter your email address to verify it's you to reset password.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                if (!isSent)
                  InputField(
                    controller: _controller,
                    hintText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
              ],
            ),
          ),
          const Spacer(),
          if (!isSent)
            ActionButton(
              title: "Verify",
              onPressed: () {
                if (validateEmail(_controller.text) != null) {
                  print("Invalid email. ${_controller.text}");
                  return;
                }
                email = _controller.text;

                //logic to send password link to mail
                Auth.resetUserPassword(email, onComplete: () {
                  setState(() {
                    isSent = true;
                  });
                }, onError: (e) {
                  showMyToast(
                    "Forget password error: $e",
                    isError: true,
                  );
                });

                // below part will be executed if mail successfully sent
              },
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
