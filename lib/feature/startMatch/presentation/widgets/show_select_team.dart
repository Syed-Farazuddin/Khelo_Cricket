import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/add_new_team.dart';
import 'package:crick_hub/common/widgets/search_team.dart';
import 'package:crick_hub/common/widgets/show_teams.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_team.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedTeam = widget.selectedTeam;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchTeam(
            onSearch: () {
              debugPrint("You searched for ${searchController.text}");
            },
            controller: searchController,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Select from your Team",
            style: CustomTextStyles.large.copyWith(fontSize: 18),
          ),
          const SizedBox(
            height: 30,
          ),
          ShowTeams(
            teams: widget.yourTeams,
            selectTeam: widget.selectTeam,
            selectedTeam: widget.selectedTeam,
          ),
          const SizedBox(
            height: 20,
          ),
          AddNewTeam(
            controller: newTeamController,
            addTeam: () async {
              await addNewTeam(name: newTeamController.text);
            },
          )
        ],
      ),
    );
  }

  Future<void> addNewTeam({required String name}) async {
    if (name.isEmpty) {
      Toaster.onError(message: "Please Enter a valid team name");
      return;
    }
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
