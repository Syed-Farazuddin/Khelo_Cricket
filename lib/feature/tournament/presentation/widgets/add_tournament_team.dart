import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/models/team_details.dart';
import 'package:crick_hub/common/widgets/add_new_team.dart';
import 'package:crick_hub/common/widgets/search_team.dart';
import 'package:crick_hub/common/widgets/show_team_info.dart';
import 'package:crick_hub/common/widgets/show_teams.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/tournament/data/tournament_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTeam extends ConsumerStatefulWidget {
  const AddTeam({
    super.key,
    required this.label,
    required this.tournamentId,
  });

  final String label;
  final int tournamentId;
  @override
  ConsumerState<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends ConsumerState<AddTeam> {
  int selectedTeam = -1;
  List<Team> teams = [];
  final TextEditingController searchController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  TeamDetails teamDetails = TeamDetails();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.label,
          style: CustomTextStyles.large,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SearchTeam(
                  onSearch: () {
                    searchTeams(name: searchController.text);
                  },
                  controller: searchController,
                ),
              ),
              if (teams.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Search results",
                        style: CustomTextStyles.large.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ShowTeams(
                        teams: teams,
                        selectTeam: (val) {
                          setState(() {
                            selectedTeam = val;
                          });
                          fetchTeamDetails(id: teams[val].teamId);
                        },
                        selectedTeam: selectedTeam,
                      ),
                      if (teamDetails.id != null)
                        ShowTeamInfo(
                          teamDetails: teamDetails,
                        )
                    ],
                  ),
                ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AddNewTeam(
                  addTeam: () {
                    registerNewTeam(
                      name: controller.text,
                      id: widget.tournamentId,
                    );
                  },
                  controller: controller,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerNewTeam({
    required String name,
    required int id,
  }) async {
    ref.read(tournamentRepositoryProvider).addNewTeam(
          teamName: name,
          tournamentId: id,
          teamId: 1,
        );
  }

  Future<void> fetchTeamDetails({
    required int id,
  }) async {
    final response =
        await ref.read(tournamentRepositoryProvider).fetchTeamDetails(
              id: id,
            );
    setState(() {
      teamDetails = response;
    });
  }

  Future<void> searchTeams({
    required String name,
  }) async {
    if (name.isEmpty) {
      setState(() {
        teams = [];
      });
      return;
    }
    final response = await ref
        .read(tournamentRepositoryProvider)
        .searchForTeams(teamName: name);
    setState(() {
      teams = response;
    });
  }
}
