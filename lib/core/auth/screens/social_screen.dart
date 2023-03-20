import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unikomb/core/auth/functions/auth/auth.dart';
import 'package:unikomb/core/auth/providers/registration_provider.dart';
import 'package:unikomb/core/auth/screens/email_verification_screen.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/core/auth/screens/skill_screen.dart';
import 'package:unikomb/core/general/screens/home_screen.dart';
import 'package:unikomb/core/storage/functions/account/account_database_api.dart';
import 'package:unikomb/utils/common_method_widgets.dart';
import 'package:unikomb/utils/utility.dart';
import 'package:unikomb/widgets/input_field.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';

import '../models/account_model.dart';

class SocialScreen extends StatefulWidget {
  static const id = "Social Screen Id";
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  TextEditingController _bioController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenPageSetup(
        children: [
          const SizedBox(height: 20),
          const AuthAppTitle(),
          const SizedBox(height: 15),
          InputField(
            controller: _bioController,
            labelText: "Bio",
            maxLines: 3,
            maxLength: 250,
          ),
          const SizedBox(height: 15),
          InputField(
            controller: _linkedinController,
            labelText: "Linkedin",
            prefixIcon: const Icon(Icons.link),
            maxLines: 1,
          ),
          const SizedBox(height: 15),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  // todo register in database and go to home screen
                  // UserModel u = UserModel(
                  //   name: name,
                  //   dob: dob,
                  //   uid: uid,
                  //   course: course,
                  //   joiningYear: joiningYear,
                  //   picUrl: picUrl,
                  //   email: email,
                  // );
                  if (!Auth.checkIfUserLoggedIn()) {
                    showMyToast("User not logged in!", isError: true);
                    return;
                  }
                  AccountModel am =
                      context.read<RegistrationProvider>().getModel();
                  AccountDatabaseApi.addAccount(am,
                      uid: Auth.getCurrentUserUid()!, onSuccess: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, EmailVerificationScreen.id, (route) => false);
                  }, onError: (e) {
                    showMyToast("Account database error: $e");
                  });
                },
                child: const Text("Skip"),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Previous"),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      if (_bioController.text != "") {
                        context
                            .read<RegistrationProvider>()
                            .setBio(_bioController.text);
                      }
                      if (_linkedinController.text != "") {
                        context
                            .read<RegistrationProvider>()
                            .setLinkedin(_linkedinController.text);
                      }
                      Navigator.pushNamed(context, SkillScreen.id);
                    },
                    child: const Text("Next"),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
