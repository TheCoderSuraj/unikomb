import 'package:flutter/material.dart';
import 'package:unikomb/core/community/models/community_model.dart';
import 'package:unikomb/utils/constants.dart';
import 'package:unikomb/widgets/action_button.dart';
import 'package:unikomb/widgets/designed_container.dart';

class CommunityWidget extends StatelessWidget {
  const CommunityWidget({
    super.key,
    required this.cm,
  });
  final CommunityModel cm;

  @override
  Widget build(BuildContext context) {
    return DesignedContainer(
      child: Column(children: [
        Row(
          children: [
            Image.network(
              cm.picUrl,
              fit: BoxFit.cover,
              height: 50,
            ),
            Text(
              cm.name,
              style: kBoldTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 15),
        ActionButton(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          title: "Description",
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        ActionButton(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          title: "General Talk",
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        ActionButton(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          title: "Course Material",
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        ActionButton(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          title: "Doubts",
          onPressed: () {},
        ),
        const SizedBox(height: 10),
        ActionButton(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          title: "Events",
          onPressed: () {},
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}
