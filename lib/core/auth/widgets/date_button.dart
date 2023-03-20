import 'package:flutter/material.dart';
import 'package:unikomb/utils/utility.dart';
import 'package:unikomb/widgets/action_button.dart';
import 'package:unikomb/widgets/designed_container.dart';

class DateButton extends StatefulWidget {
  const DateButton({
    super.key,
    required this.initialTime,
    this.onChanged,
    this.title,
    this.widthRatio = 0.6,
  });
  final DateTime initialTime;
  final Function(DateTime)? onChanged;
  final String? title;
  final double widthRatio;

  @override
  State<DateButton> createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  @override
  Widget build(BuildContext context) {
    var tit = widget.title;
    var val = convertDateToString(widget.initialTime);
    return ActionButton(
      widthRatio: widget.widthRatio,
      title: tit == null ? val : "$tit: $val",
      onPressed: () {
        showChangeDateDialog();
      },
    );
  }

  void showChangeDateDialog() async {
    // DateTime lastTime =
    DateTime? res = await showDatePicker(
      context: context,
      initialDate: widget.initialTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (res == null) return;
    if (widget.onChanged != null) {
      widget.onChanged!(DateTime(res.year, res.month, res.day));
    }
  }
}
