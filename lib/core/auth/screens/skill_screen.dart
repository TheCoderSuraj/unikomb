import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/models/skill_model.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/core/auth/screens/projects_screen.dart';
import 'package:unikomb/core/auth/widgets/skill_widget.dart';
import 'package:unikomb/widgets/input_field.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';

import '../../../utils/constants.dart';
import '../../../widgets/action_button.dart';

class SkillScreen extends StatefulWidget {
  static const id = "Skill Screen Id";
  const SkillScreen({super.key});

  @override
  State<SkillScreen> createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  List<SkillModel> _skills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: kPagePadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 25),
                      const AuthAppTitle(),
                      const SizedBox(height: 15),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _skills.length,
                        itemBuilder: (context, index) => SkillWidget(
                          skill: _skills[index],
                        ),
                      ),
                      const SizedBox(height: 15),
                      ActionButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 6),
                        widthRatio: 0.7,
                        onPressed: () {
                          showAddSkillDialog();
                        },
                        title: 'Add New Skill',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Skip"),
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
                        Navigator.pushNamed(context, ProjectsScreen.id);
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
      ),
    );
  }

  void showAddSkillDialog() {
    TextEditingController _skillController = TextEditingController();
    TextEditingController _levelController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Skill"),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(
                labelText: "Skill",
                controller: _skillController,
              ),
              const SizedBox(height: 15),
              InputField(
                controller: _levelController,
                labelText: "level",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              int? t = int.tryParse(_levelController.text);
              if (t == null) {
                return;
              }
              setState(() {
                _skills.add(
                  SkillModel(title: _skillController.text, level: t),
                );
              });
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
