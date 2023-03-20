import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unikomb/core/auth/providers/registration_provider.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/core/auth/screens/skill_screen.dart';
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
