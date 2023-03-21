import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/functions/auth/auth.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/core/community/models/community_model.dart';
import 'package:unikomb/core/general/screens/profile_screen.dart';
import 'package:unikomb/core/general/screens/settings_screen.dart';
import 'package:unikomb/core/general/widgets/community_widget.dart';
import 'package:unikomb/core/storage/functions/community/community_api.dart';
import 'package:unikomb/utils/common_method_widgets.dart';

import '../../../widgets/screen_page_setup.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HomeScreenId";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CommunityModel> communities = [
    // CommunityModel(
    //     name: "Learn DSA",
    //     picUrl:
    //         "https://firebasestorage.googleapis.com/v0/b/unikomb1.appspot.com/o/community%2Fworkflow.png?alt=media&token=5019c23e-1d49-47de-b5cc-bcf401c2ab46",
    //     createdBy: "c6SUdqoHEOfCzysjmfULphkB9u52",
    //     creationDate: 134415876222,
    //     skill: "c++"),
  ];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    // communities.add(await CommunityApi.getCommunity("CVwWzwQ9nUuNm00jwX4E") );
    CommunityModel? c1 =
        await CommunityApi.getCommunity("CVwWzwQ9nUuNm00jwX4E");
    CommunityModel? c2 =
        await CommunityApi.getCommunity("PyfK1ZakL4GDEk7O9gf5");
    // if (c == null) {
    //   print("We get null community");
    //   return;
    // }
    communities.add(c1!);
    communities.add(c2!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("we got a call");
          CommunityApi.addCommunityFireStore(CommunityModel(
              name: "Web Development",
              picUrl: "picUrl",
              createdBy: "",
              creationDate: Timeline.now,
              skill: "Javascript"));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 90,
              color: Colors.blue,
              height: double.maxFinite,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 50,
                  ),
                  const SizedBox(height: 35),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ProfileScreen.id);
                    },
                    icon: const Icon(
                      Icons.perm_identity,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 35),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SettingsScreen.id);
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
            Column(
              children: communities.map((e) => CommunityWidget(cm: e)).toList(),
            )
          ],
        ),
      ),
    );
  }
}
