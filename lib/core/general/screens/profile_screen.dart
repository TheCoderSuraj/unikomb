import 'dart:math';

import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/functions/auth/auth.dart';
import 'package:unikomb/core/auth/models/account_model.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/core/general/screens/single_project_screen.dart';
import 'package:unikomb/core/general/widgets/github_webview.dart';
import 'package:unikomb/core/general/widgets/leetcote_showcase.dart';
import 'package:unikomb/core/general/widgets/project_button.dart';
import 'package:unikomb/core/storage/functions/account/account_database_api.dart';
import 'package:unikomb/utils/common_method_widgets.dart';
import 'package:unikomb/utils/constants.dart';
import 'package:unikomb/widgets/designed_container.dart';
import 'package:unikomb/widgets/profile_pic.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';
import 'package:unikomb/widgets/spinning_widget.dart';

import '../../../utils/asset_path.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "Profile Screen Id";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AccountModel? am;
  bool isLoaded = false;
  // bool isLoaded = false;
  @override
  void initState() {
    // am = AccountModel.demo();
    accountDataSetup();
    super.initState();
  }

  void accountDataSetup() async {
    if (!Auth.checkIfUserLoggedIn()) {
      am = null;
      showMyToast("Error: User not logged in.", isError: true);
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.id, (route) => false);
    } else {
      am = await AccountDatabaseApi.getAccount(Auth.getCurrentUserUid()!,
          onError: (e) {
        showMyToast("Error on getting account details", isError: true);
      }, onSuccess: (ac) {
        setState(() {});
      });
    }
    if (am == null) {
      Navigator.pop(context);
      showMyToast("Null account details");
    }
    setState(() {
      isLoaded = true;
    });
    print("account is ${am?.toJson().toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: isLoaded
          ? ScreenPageSetup(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          ProfilePic(
                            image: (am?.picUrl != null
                                ? NetworkImage(am!.picUrl)
                                : AssetImage(apProfilePic)) as ImageProvider,
                            radius: 50,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            am!.name,
                            style: kBoldTextStyle,
                          ),
                          Text(
                            am!.uid,
                            style: kSmallTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DesignedContainer(
                          child: Wrap(
                            spacing: 2,
                            children: am!.skills
                                .map((e) => Chip(label: Text(e.title)))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Bio
                const SizedBox(height: 5),
                Text(
                  am?.bio ?? "Exploring and open to learn...",
                  style: kDefaultTextStyle,
                ),

                if (am?.leetUsername == null)
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 40,
                      child: Image.asset(
                        apLeetCodeLogo,
                        height: 80,
                      ),
                    ),
                    onTap: () {
                      showLeetCodeUsernameDialog();
                    },
                  ),

                if (am?.leetUsername != null)
                  LeetcodeShowcase(username: am!.leetUsername!),
                // DesignedContainer(
                //   child: Wrap(children: [
                //     if (am?.leetUsername == null)
                //       GestureDetector(
                //         child: CircleAvatar(
                //           radius: 40,
                //           child: Image.asset(
                //             apLeetCodeLogo,
                //             height: 80,
                //           ),
                //         ),
                //         onTap: () {
                //           showLeetCodeUsernameDialog();
                //         },
                //       ),
                //   ]),
                // ),
                // Row(
                //   children: [
                //     Image.asset(
                //       apMedal,
                //       fit: BoxFit.cover,
                //       height: 40,
                //     ),
                //     const SizedBox(width: 10),
                //     Text(
                //       "123",
                //       style: kSemiBoldTextStyle,
                //     ),
                //   ],
                // ),
                // SingleChildScrollView(
                //     scrollDirection: Axis.horizontal, child: GithumWebview()),
                // github
                // Image.network(
                //     "https://github-contributions-api.deno.dev/Thecodersuraj.svg"),

                // Projects
                const SizedBox(height: 10),
                if (am!.projects.isNotEmpty)
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Projects",
                          style: kSubtitleTextStyle.copyWith(
                              decoration: TextDecoration.underline),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 15,
                          runSpacing: 3,
                          children: am!.projects
                              .map(
                                (e) => ProjectButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      SingleProjectScreen.id,
                                      arguments: e,
                                    );
                                  },
                                  title: e.title,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
              ],
            )
          : const SpinningWidget(),
    );
  }

  void showLeetCodeUsernameDialog() {
    TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("Leetcode Username"),
        children: [
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.text,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    am?.leetUsername = _controller.text;
                  });
                  if (_controller.text.length < 3) return;
                  AccountDatabaseApi.updateAccount(Auth.getCurrentUserUid()!,
                      {"leetcodeUsername": _controller.text}, onSuccess: () {
                    showMyToast("Successfully added");
                  }, onError: (e) {
                    showMyToast("Error occurred: $e", isError: true);
                  });
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
