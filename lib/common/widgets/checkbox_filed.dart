import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CheckboxFiled extends StatefulWidget {
  const CheckboxFiled({
    super.key,
    required this.label,
    required this.onChanged,
    required this.value,
  });
  final Function(bool? val) onChanged;
  final bool value;
  final String label;

  @override
  State<CheckboxFiled> createState() => _CheckboxFiledState();
}

class _CheckboxFiledState extends State<CheckboxFiled> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.value,
          onChanged: widget.onChanged,
        ),
        Text(
          widget.label,
          style: CustomTextStyles.large,
        ),
      ],
    );
  }
}
