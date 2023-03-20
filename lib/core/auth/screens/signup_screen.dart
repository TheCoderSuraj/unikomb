import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/asset_path.dart';
import '../../../utils/common_method_widgets.dart';
import '../../../utils/constants.dart';
import '../../../utils/validity_methods.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/screen_page_setup.dart';
import '../../../widgets/spinning_widget.dart';
import '../../general/providers/shared_pref_provider.dart';
import '../../general/screens/home_screen.dart';
import '../functions/auth/auth.dart';
import '../widgets/password_field.dart';
import 'additional_details_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const id = "SignUpScreenId";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLogin = true;
  bool rememberMe = true;
  bool hidePassword = true;
  bool isLoading = false;
  TextEditingController _idController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  // these are only for login page
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: isLoading
            ? const SpinningWidget()
            : ScreenPageSetup(
                padding: const EdgeInsets.all(0),
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const AuthAppTitle(),

                  const SizedBox(height: 30),
                  Image.asset(
                    apRegisterPic,
                    height: 250,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Sign Up Screen",
                    style: kTitleTextStyle,
                  ),
                  const SizedBox(height: 20),
                  buildSignUpWidget(),
                  const Spacer(),
                  // const AuthBottomWidget(),
                ],
              ),
      ),
    );
  }

  Widget buildSignUpWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          InputField(
            validator: validateEmail,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: "Email Address",
            prefixIcon: const Icon(Icons.mail_outline),
          ),
          const SizedBox(height: 15),
          PasswordField(
            controller: _passwordController,
            labelText: "Password",
          ),
          const SizedBox(height: 10),
          PasswordField(
            controller: _confirmPasswordController,
            labelText: "Confirm Password",
            validator: (value) {
              if (value == null || value == "") {
                return "Confirm password is required";
              } else if (value != _passwordController.text) {
                return "Password does not match";
              }
            },
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 15),
          ActionButton(
            widthRatio: .7,
            title: "Sign Up",
            onPressed: () async {
              if (!(_key.currentState?.validate() ?? false)) return;
              setState(() {
                isLoading = true;
              });
              // register code

              Auth.registerUser(
                _emailController.text,
                _passwordController.text,
                onComplete: () {
                  setState(() {
                    isLoading = false;
                    Navigator.pushNamed(context, AdditionalDetailsScreen.id,
                        arguments: Auth.getUserEmailAddress());
                  });
                },
                onError: (error) {
                  setState(() {
                    isLoading = false;
                  });
                  showMyToast("Error: $error", isError: true);
                },
              );
            },
          ),
          const SizedBox(height: 15),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                child: const Text("Log In!"),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.id, (route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
