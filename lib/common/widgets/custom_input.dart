import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    this.label = "Enter Number of players",
    this.maxlength = 2,
  });
  final TextEditingController controller;
  final String label;
  final int maxlength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 0.3,
            color: Colors.white,
          ),
        ),
        child: TextField(
          controller: controller,
          // maxLength: 10,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(maxlength)
          ],
          decoration: InputDecoration(
            hintText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
