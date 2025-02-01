import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/checkbox_filed.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_date_picker.dart';
import 'package:crick_hub/common/widgets/custom_image_selector.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/feature/tournament/data/tournament_repository.dart';
import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';
import 'package:crick_hub/feature/tournament/presentation/pages/tournament_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartTournament extends ConsumerStatefulWidget {
  const StartTournament({super.key});

  @override
  ConsumerState<StartTournament> createState() => _StartTournamentState();
}

class _StartTournamentState extends ConsumerState<StartTournament> {
  final TextEditingController name = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController place = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  bool openForAll = false;
  bool registrationsOpen = false;

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
          CustomInputField(
            label: "Place",
            controller: place,
            textAllowed: true,
          ),
          const CustomImageSelector(),
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
          CheckboxFiled(
            label: 'Open For All',
            onChanged: (value) {
              setState(() {
                openForAll = value ?? false;
              });
            },
            value: openForAll,
          ),
          CheckboxFiled(
            label: 'Registrations open?',
            onChanged: (value) {
              setState(() {
                registrationsOpen = value ?? false;
              });
            },
            value: registrationsOpen,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Custombutton(
                    onTap: () async {
                      final result = await ref
                          .read(tournamentRepositoryProvider)
                          .registerTournament(
                            RegisterTournamentRequest(
                              endDate: endDate.text,
                              place: place.text,
                              startDate: startDate.text,
                              imageUrl:
                                  'https://img.freepik.com/premium-vector/cricket-championship-tournament-match-background_30996-6111.jpg',
                              name: name.text,
                              openForAll: openForAll,
                              registrationsOpen: registrationsOpen,
                            ),
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => TournamentInfo(
                            data: result,
                          ),
                        ),
                      );
                    },
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
}
