import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/select_team_player.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/show_select_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectTeam extends ConsumerStatefulWidget {
  const SelectTeam({
    super.key,
    required this.teamName,
    required this.fetchYourTeams,
    required this.teamNo,
  });
  final int teamNo;
  final String teamName;
  final Future<void> Function() fetchYourTeams;

  @override
  ConsumerState<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends ConsumerState<SelectTeam> {
  bool teamSelected = false;
  int selectedTeam = 0;
  SelectedTeamIds teams = SelectedTeamIds();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Team> yourTeams = ref.watch(teamDataProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: !teamSelected
            ? ShowSelectTeam(
                teamIds: teams,
                refreshTeamsData: widget.fetchYourTeams,
                yourTeams: yourTeams,
                selectedTeam: selectedTeam,
                selectTeam: (val) {
                  setState(
                    () {
                      selectedTeam = val;
                      teamSelected = true;
                    },
                  );
                },
              )
            : SelectTeamPlayer(
                team: yourTeams[selectedTeam],
                teamNo: widget.teamNo,
                refreshTeamsData: widget.fetchYourTeams,
              ),
      ),
    );
  }
}

class SelectedTeamIds {
  int? teamA;
  int? teamB;
  SelectedTeamIds({
    this.teamB,
    this.teamA,
  });
}
