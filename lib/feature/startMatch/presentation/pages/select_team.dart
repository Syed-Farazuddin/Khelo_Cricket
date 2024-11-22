import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/select_team_player.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/show_select_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectTeam extends ConsumerStatefulWidget {
  const SelectTeam({
    super.key,
    required this.teamName,
    required this.selectedPlayers,
  });
  final String teamName;
  final List selectedPlayers;
  @override
  ConsumerState<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends ConsumerState<SelectTeam> {
  bool teamSelected = false;
  late List<Team> yourTeams = [];

  final TextEditingController _controller = TextEditingController();
  int selectedTeam = 0;

  @override
  void initState() {
    fetchYourTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: !teamSelected
            ? ShowSelectTeam(
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
                controller: _controller,
                players: yourTeams[selectedTeam].players,
                teamId: yourTeams[selectedTeam].teamId,
                teamName: teamSelected
                    ? yourTeams[selectedTeam].name.toString()
                    : "Team not Selected",
                selectedPlayers: widget.selectedPlayers as List<int>,
                refreshData: fetchYourTeams,
              ),
      ),
    );
  }

  Future<void> fetchYourTeams() async {
    final res =
        await ref.read(startMatchControllerProvider.notifier).fetchYourTeams();
    setState(() {
      yourTeams = res;
    });
  }
}
