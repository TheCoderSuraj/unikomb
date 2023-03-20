import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/screens/additional_details_screen.dart';
import 'package:unikomb/core/auth/screens/social_screen.dart';
import '../core/auth/screens/email_verification_screen.dart';
import '../core/auth/screens/forget_password_screen.dart';
import '../core/auth/screens/login_screen.dart';
import '../core/auth/screens/signup_screen.dart';
import '../core/general/screens/error_screen.dart';
import '../core/general/screens/on_boarding_screen.dart';
import '../core/general/screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // Auth

      case SocialScreen.id:
        return MaterialPageRoute(
          builder: (context) => const SocialScreen(),
        );
      case AdditionalDetailsScreen.id:
        return MaterialPageRoute(
          builder: (context) => const AdditionalDetailsScreen(),
        );
      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case SignUpScreen.id:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case ForgetPasswordScreen.id:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );
      case EmailVerificationScreen.id:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      // General
      case SplashScreen.id:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case OnBoardingScreen.id:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case ErrorScreen.id:
        if (args is String) {
          return _buildError(message: args);
        }
        return _buildError(message: "Error Screen: Invalid Message");

      // error
      default:
        return _buildError();
    }
  }

  static Route<dynamic>? _buildError({String message = "Unknown Error"}) {
    return MaterialPageRoute(
      builder: (context) => ErrorScreen(message: message),
    );
  }
}
