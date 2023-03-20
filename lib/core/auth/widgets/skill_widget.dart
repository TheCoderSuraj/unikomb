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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(skill.title),
          Text(skill.level.toString()),
          // Slider(

          //   min: 0,
          //   max: 10,
          //   value: skill.level.toDouble(),
          //   onChanged: (double value) {},
          // )
        ],
      ),
    );
  }
}
