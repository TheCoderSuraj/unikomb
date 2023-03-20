import 'package:flutter/material.dart';
import 'package:unikomb/utils/constants.dart';
import 'package:unikomb/widgets/profile_pic.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ScreenPageSetup(children: [
        const SizedBox(height: 15),
        ProfilePic(
          image: NetworkImage(kTestImgUrl),
        ),
      ]),
    );
  }
}
