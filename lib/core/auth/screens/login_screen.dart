import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unikomb/core/auth/screens/signup_screen.dart';
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
  @override
  void initState() {
    super.initState();
    final t = context.read<SharedPrefProvider>();
    _emailController.text = t.loginEmail;
    _passwordController.text = t.loginPassword;
    if (Auth.checkIfUserLoggedIn()) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.id, (route) => false);
    }
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
                  const SizedBox(height: 30),
                  const AuthAppTitle(),

                  const SizedBox(height: 30),
                  Image.asset(
                    apLoginPic,
                    height: 250,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Log In Screen",
                    style: kTitleTextStyle,
                  ),
                  const SizedBox(height: 20),
                  buildLoginPage(),

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
          const SizedBox(height: 15),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                child: const Text("Sign Up!"),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignUpScreen.id, (route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void userLogIn() async {
    setState(() {
      isLoading = true;
    });
    Auth.signInUser(_emailController.text, _passwordController.text,
        onComplete: () {
      // saving email and password for remember me option
      String email = rememberMe ? _emailController.text : "";
      String password = rememberMe ? _passwordController.text : "";
      context.read<SharedPrefProvider>().changeLoginEmail(email);
      context.read<SharedPrefProvider>().changeLoginPassword(password);

      // fetching user data from database
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (r) => false);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             EmailVerificationScreen(email: "surajthecoder@gmail.com")));
      if (Auth.checkIfEmailIsVerified()) {
        print("home screen");
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (r) => false);
      } else {
        print("email verification ${Auth.getUserEmailAddress()}");
        Navigator.pushNamed(
          context,
          EmailVerificationScreen.id,
          arguments: Auth.getUserEmailAddress(),
        );
      }
    }, onError: (error) {
      setState(() {
        isLoading = false;
      });
      showMyToast("Error: $error", isError: true);
    });
  }
}

class AuthAppTitle extends StatelessWidget {
  const AuthAppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          kAppName,
          style: kTitleTextStyle,
        ),
        const SizedBox(width: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            apAppLogo,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
