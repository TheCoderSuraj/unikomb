import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class MyToggleButton extends StatefulWidget {
  const MyToggleButton({
    super.key,
    required this.first,
    required this.second,
    required this.onChange,
    required this.value,
    required this.textStyle,
  });
  final String first;
  final String second;
  final Function(bool) onChange;
  final bool value;
  final TextStyle textStyle;

  @override
  State<MyToggleButton> createState() => _MyToggleButtonState();
}

class _MyToggleButtonState extends State<MyToggleButton> {
  bool value = true;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if (!widget.value) {
                setState(() {
                  value = !value;
                });
                widget.onChange(value);
              }
            },
            child: Text(
              widget.first,
              style: widget.textStyle.copyWith(
                color: value ? kLightBlueColor : Colors.grey,
                decoration:
                    value ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(width: 30),
          GestureDetector(
            onTap: () {
              if (widget.value) {
                setState(() {
                  value = !value;
                });
                widget.onChange(value);
              }
            },
            child: Text(
              widget.second,
              style: widget.textStyle.copyWith(
                color: !value ? kLightBlueColor : Colors.grey,
                decoration:
                    !value ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
