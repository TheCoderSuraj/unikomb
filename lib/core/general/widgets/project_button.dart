import 'package:flutter/material.dart';
import 'package:unikomb/utils/constants.dart';
import 'package:unikomb/widgets/designed_container.dart';

class ProjectButton extends StatelessWidget {
  const ProjectButton({
    super.key,
    required this.title,
    this.gradient,
    this.onPressed,
  });
  final String title;
  final Gradient? gradient;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: DesignedContainer(
        minHeight: 200,
        width: MediaQuery.of(context).size.width * 0.44,
        gradient: gradient,
        child: Center(
          child: Text(
            title,
            style: kSemiBoldTextStyle,
          ),
        ),
      ),
    );
  }
}
