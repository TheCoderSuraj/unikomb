import 'package:flutter/material.dart';
import '../../../utils/common_method_widgets.dart';
import '../../../utils/constants.dart';
import '../../../utils/validity_methods.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/screen_page_setup.dart';
import '../../../widgets/spinning_widget.dart';
import '../../general/screens/home_screen.dart';
import '../functions/auth/auth.dart';
import '../widgets/my_toggle_button.dart';
import '../widgets/password_field.dart';
import 'email_verification_screen.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = "LoginScreenId";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  void initState() {
    super.initState();
    // final t = context.read<SharedPrefProvider>();
    // _emailController.text = t.loginEmail;
    // _passwordController.text = t.loginPassword;
    // if (Auth.checkIfUserLoggedIn()) {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, MemeListPage.id, (route) => false);
    // }
  }

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
                  const SizedBox(height: 80),
                  Text(
                    isLogin ? "Log In" : "Register",
                    style: kTitleTextStyle,
                  ),
                  const Text(
                    "By signing in, you will agree to ",
                    style: kDefaultTextStyle,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        "our",
                        style: kDefaultTextStyle,
                      ),
                      TextButton(
                        onPressed: () async {},
                        child: const Text("Terms and privacy policy"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  MyToggleButton(
                    first: "Log In",
                    second: "Register",
                    onChange: (val) {
                      setState(() {
                        isLogin = val;
                      });
                      _emailController.clear();
                      _passwordController.clear();
                      print(
                        "is Login $isLogin",
                      );
                    },
                    value: isLogin,
                    textStyle: kSubtitleTextStyle,
                  ),
                  const SizedBox(height: 50),
                  if (isLogin) buildLoginPage(),
                  if (!isLogin) buildSignUpPage(),
                  const Spacer(),
                  // const AuthBottomWidget(),
                ],
              ),
      ),
    );
  }

  Widget buildLoginPage() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? true;
                      });
                    },
                  ),
                  // const SizedBox(width: 10),
                  const Text(
                    "Remember Me",
                    // style: kDefaultTextStyle,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ForgetPasswordScreen.id);
                },
                child: const Text("Forget Password?"),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ActionButton(
            widthRatio: .7,
            title: "Log In",
            onPressed: () {
              if (!(_key.currentState?.validate() ?? false)) return;

              // login code

              userLogIn();
            },
          ),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildSignUpPage() {
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
                    Navigator.pushNamed(context, EmailVerificationScreen.id,
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
          // const SizedBox(height: 20),
        ],
      ),
    );
  }

  void userLogIn() async {
    setState(() {
      isLoading = true;
    });
    Auth.signInUser(_emailController.text, _passwordController.text,
        onComplete: () async {
      // saving email and password for remember me option
      String email = rememberMe ? _emailController.text : "";
      String password = rememberMe ? _passwordController.text : "";
      // context.read<SharedPrefProvider>().changeLoginEmail(email);
      // context.read<SharedPrefProvider>().changeLoginPassword(password);

      // fetching user data from database
      if (Auth.checkIfEmailIsVerified()) {
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (r) => false);
      } else {
        Navigator.pushNamed(
          context,
          EmailVerificationScreen.id,
          arguments: Auth.getUserEmailAddress(),
        );
      }
      setState(() {
        isLoading = false;
      });
    }, onError: (error) {
      setState(() {
        isLoading = false;
      });
      showMyToast("Error: $error", isError: true);
    });
  }
}
