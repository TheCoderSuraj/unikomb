import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.widthRatio = 0.6,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    this.radius = 8,
    this.style = const TextStyle(
      fontSize: 25,
    ),
  });
  final Function()? onPressed;
  final String title;

  /// `button minimum width = widthRatio * screen width`
  final double widthRatio;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double radius;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(width * widthRatio, 25),
        // minimumSize: Size(getWidgetWidthRatio(width, widthRatio), 25),
        padding: padding,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      child: Text(
        title,
        style: style,
      ),
    );
  }
}
