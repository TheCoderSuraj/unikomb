import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/models/project_model.dart';
import 'package:unikomb/utils/common_method_widgets.dart';
import 'package:unikomb/utils/constants.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleProjectScreen extends StatelessWidget {
  static const id = "Single Project Screen Id";
  const SingleProjectScreen({
    super.key,
    required this.project,
  });
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Details"),
      ),
      body: ScreenPageSetup(
        children: [
          Text(
            project.title,
            style: kSubtitleTextStyle,
          ),
          const SizedBox(height: 10),
          Wrap(
            runSpacing: 4,
            spacing: 4,
            children:
                project.skill.map((e) => Chip(label: Text(e.title))).toList(),
          ),
          const SizedBox(height: 10),
          Text(
            project.desc,
            style: kDefaultTextStyle,
          ),
          const SizedBox(height: 5),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text("Url: "),
              TextButton(
                onPressed: () async {
                  if (!await canLaunchUrl(Uri.parse(project.url))) {
                    showMyToast("Error: Invalid Url", isError: true);
                    return;
                  }
                  launchUrl(Uri.parse(project.url));
                },
                child: Text("${project.url}"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
