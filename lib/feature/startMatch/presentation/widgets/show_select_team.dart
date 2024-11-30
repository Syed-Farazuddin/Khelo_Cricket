import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_team.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowSelectTeam extends ConsumerStatefulWidget {
  const ShowSelectTeam({
    super.key,
    required this.yourTeams,
    required this.selectTeam,
    required this.selectedTeam,
    required this.refreshTeamsData,
    required this.teamIds,
  });
  final List<Team> yourTeams;
  final SelectedTeamIds teamIds;
  final int selectedTeam;
  final Future<void> Function() refreshTeamsData;

  final Function(int value) selectTeam;

  @override
  ConsumerState<ShowSelectTeam> createState() => _ShowSelectTeamState();
}

class _ShowSelectTeamState extends ConsumerState<ShowSelectTeam> {
  TextEditingController newTeamController = TextEditingController();
  late int selectedTeam;
  @override
  void initState() {
    super.initState();
    selectedTeam = widget.selectedTeam;
  }

  @override
  Widget build(BuildContext context) {
    // Team teamA = widget.yourTeams
    //     .where(
    //       (team) => team.teamId == widget.teamIds.teamA,
    //     )
    //     .toList()[0];
    // Team teamB = widget.yourTeams
    //     .where(
    //       (team) => team.teamId == widget.teamIds.teamB,
    //     )
    //     .toList()[0];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select your Team",
            style: GoogleFonts.golosText(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          showteams(teams: widget.yourTeams),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Add new Team",
            style: GoogleFonts.golosText(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomInputField(
            controller: newTeamController,
            label: 'Enter team name',
            textAllowed: true,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Custombutton(
                    onTap: () async {
                      await addNewTeam(name: newTeamController.text);
                    },
                    title: "Add",
                    width: 100,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget showteams({required List<Team> teams}) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: teams.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (builder, index) {
        return GestureDetector(
          onTap: () => widget.selectTeam(index),
          child: Container(
            decoration: BoxDecoration(
              color: index == selectedTeam
                  ? Colors.blue
                  : Colors.white.withOpacity(
                      0.18,
                    ),
              border: Border.all(
                color: Colors.white.withOpacity(
                  0.2,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                teams[index].name,
                style: GoogleFonts.golosText(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> addNewTeam({required String name}) async {
    await ref
        .read(
          startMatchControllerProvider.notifier,
        )
        .addNewTeam(name: name);
    setState(() {
      widget.refreshTeamsData();
    });
  }
}
