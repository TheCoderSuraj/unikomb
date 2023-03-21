import 'package:flutter/material.dart';
import 'package:unikomb/utils/common_method_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';
import '../../../widgets/designed_container.dart';
import '../models/project_model.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({
    super.key,
    required this.project,
  });
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    print("we got a project: ${project.toJson()}");
    return DesignedContainer(
      child: Column(
        children: [
          Text(
            project.title,
            style: kSubtitleTextStyle,
          ),
          // const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              children:
                  project.skill.map((e) => Chip(label: Text(e.title))).toList(),
            ),
          ),
          Text(project.desc),
          const SizedBox(height: 2),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () async {
                Uri t = Uri.parse(project.url);
                if (!await canLaunchUrl(t)) {
                  showMyToast("Invalid Url", isError: true);
                  return;
                }
                await launchUrl(t);
              },
            ),
          )
        ],
      ),
    );
  }
}
