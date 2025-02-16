import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SquareInputField extends StatelessWidget {
  const SquareInputField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 150,
        maxHeight: 150,
      ),
      child: TextField(
        controller: controller,
        onChanged: (val) {
          if (int.parse(val) >= 8) {
            controller.text = '';
            Toaster.onError(message: "You can only Enter values less than 8");
          }
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Allows only numbers
          LengthLimitingTextInputFormatter(8), // Restricts to 8 characters max
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
