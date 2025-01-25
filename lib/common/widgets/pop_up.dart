import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  const PopUp({
    super.key,
    required this.label,
    required this.onTap,
  });
  final String label;
  final Function() onTap;

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
        height: 200, // Fixed height, adjust as needed
        padding: const EdgeInsets.all(20), // Add some padding
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "End Inning",
              style: CustomTextStyles.heading,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Custombutton(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  title: "Back",
                  width: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Custombutton(
                  onTap: widget.onTap,
                  title: widget.label,
                  width: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
