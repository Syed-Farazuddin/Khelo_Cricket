import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.label,
    required this.onSelectDate,
    required this.selectedDate,
  });
  final Function(String date) onSelectDate;
  final String label;
  final String selectedDate;
  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 14,
      ),
      child: GestureDetector(
        onTap: () async {
          DateTime? date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 1),
          );
          if (date != null) {
            String newDate = date.toString().split(' ')[0];
            widget.onSelectDate(newDate);
            setState(() {});
          }
        },
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.label,
              style: CustomTextStyles.large.copyWith(
                fontWeight: widget.selectedDate.isNotEmpty
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
