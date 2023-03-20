import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/models/skill_model.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/core/auth/widgets/skill_widget.dart';
import 'package:unikomb/widgets/input_field.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';

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
      body: ScreenPageSetup(
        children: [
          const SizedBox(height: 25),
          const AuthAppTitle(),
          const SizedBox(height: 15),
          ListView.builder(
            itemBuilder: (context, index) => SkillWidget(
              skill: _skills[index],
            ),
          ),
        ],
      ),
    );
  }

  void showAddSkillDialog() {
    TextEditingController _skillController = TextEditingController();
    TextEditingController _levelController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text("Add Skill"),
          content: Column(
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

                _skills.add(
                  SkillModel(title: _skillController.text, level: t),
                );
                setState(() {});
              },
              child: const Text("Add"),
            ),
          ],
        );
      }),
    );
  }
}
