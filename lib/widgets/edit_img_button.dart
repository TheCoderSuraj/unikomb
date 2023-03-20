import 'package:flutter/material.dart';

/// only use this widget inside `stack`
class EditImgButton extends StatelessWidget {
  const EditImgButton({
    required this.onPressed,
    super.key,
  });
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: Material(
        borderRadius: BorderRadius.circular(25),
        clipBehavior: Clip.antiAlias,
        child: Ink(
          color: Colors.blue,
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: onPressed,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
