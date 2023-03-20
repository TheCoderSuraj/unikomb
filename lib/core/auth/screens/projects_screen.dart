import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/core/general/screens/home_screen.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';

import '../../../utils/common_method_widgets.dart';
import '../../../utils/constants.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/input_field.dart';
import '../../storage/functions/account/account_database_api.dart';
import '../functions/auth/auth.dart';
import '../models/account_model.dart';
import '../models/project_model.dart';
import '../providers/registration_provider.dart';
import '../widgets/project_widget.dart';
import 'email_verification_screen.dart';

class ProjectsScreen extends StatefulWidget {
  static const id = "Projects Screen Id";
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<ProjectModel> _projects = [];

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
                        itemCount: _projects.length,
                        itemBuilder: (context, index) => ProjectWidget(
                          project: _projects[index],
                        ),
                      ),
                      const SizedBox(height: 15),
                      ActionButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 6),
                        widthRatio: 0.7,
                        onPressed: () {
                          showAddProjectDialog();
                        },
                        title: 'Add New Project',
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
                  onPressed: () {
                    if (!Auth.checkIfUserLoggedIn()) {
                      showMyToast("User not logged in!", isError: true);
                      return;
                    }
                    AccountModel am =
                        context.read<RegistrationProvider>().getModel();
                    AccountDatabaseApi.addAccount(am,
                        uid: Auth.getCurrentUserUid()!, onSuccess: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          EmailVerificationScreen.id, (route) => false);
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
                        AccountModel am =
                            context.read<RegistrationProvider>().getModel();
                        Navigator.pushNamed(context, EmailVerificationScreen.id,
                            arguments: Auth.getUserEmailAddress());
                        AccountDatabaseApi.addAccount(am,
                            uid: Auth.getCurrentUserUid()!);
                      },
                      child: const Text("Done"),
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

  void showAddProjectDialog() {
    TextEditingController _skillController = TextEditingController();
    TextEditingController _descController = TextEditingController();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Project"),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputField(
                labelText: "Title",
                controller: _titleController,
              ),
              const SizedBox(height: 15),
              InputField(
                controller: _descController,
                labelText: "Desc",
                keyboardType: TextInputType.text,
                maxLines: 2,
                maxLength: 300,
              ),
              const SizedBox(height: 15),
              InputField(
                controller: _skillController,
                labelText: "Skill",
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              const SizedBox(height: 15),
              InputField(
                controller: _urlController,
                labelText: "Url",
                keyboardType: TextInputType.url,
                maxLines: 1,
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
              setState(() {
                _projects.add(
                  ProjectModel(
                    title: _titleController.text,
                    desc: _descController.text,
                    skill: [_skillController.text],
                    url: _urlController.text,
                  ),
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
