import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_date_picker.dart';
import 'package:crick_hub/common/widgets/custom_image_selector.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartTournament extends ConsumerStatefulWidget {
  const StartTournament({
    super.key,
  });

  @override
  ConsumerState<StartTournament> createState() => _StartTournamentState();
}

class _StartTournamentState extends ConsumerState<StartTournament> {
  TextEditingController name = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register for a tournament',
          style: CustomTextStyles.large,
        ),
      ),
      body: Column(
        children: [
          CustomInputField(
            label: "Tournament name",
            controller: name,
            textAllowed: true,
          ),
          const CustomImageSelector(),
          // DatePicker
          CustomDatePicker(
            label: startDate.text.isEmpty
                ? "Select Start Date"
                : "Start Date : ${startDate.text}",
            selectedDate: startDate.text,
            onSelectDate: (d) {
              setState(() {
                startDate.text = d;
              });
              debugPrint("New date is selected $d");
            },
          ),
          CustomDatePicker(
            label: endDate.text.isEmpty
                ? "Select End Date"
                : "End Date : ${endDate.text}",
            selectedDate: endDate.text,
            onSelectDate: (d) {
              setState(() {
                endDate.text = d;
              });
              debugPrint("New date is selected $d");
            },
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Custombutton(
                    onTap: () {},
                    title: "Register",
                    width: 100,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> startTournament() async {
    // await
  }

  Widget customDatePicker() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: DatePickerDialog(
        firstDate: DateTime.now(),
        selectableDayPredicate: (sx) {
          final s = sx;
          debugPrint("S is $s");
          return false;
        },
        lastDate: DateTime(DateTime.now().year + 1),
      ),
    );
  }
}
