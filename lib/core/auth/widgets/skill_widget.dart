import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/models/skill_model.dart';
import 'package:unikomb/widgets/designed_container.dart';

class SkillWidget extends StatelessWidget {
  const SkillWidget({
    super.key,
    required this.skill,
  });
  final SkillModel skill;

  @override
  Widget build(BuildContext context) {
    return DesignedContainer(
      child: Row(
        children: [
          Text(skill.title),
        ],
      ),
    );
  }
}
