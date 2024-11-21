import 'package:crick_hub/feature/startMatch/data/models/models.dart';
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
  late List yourTeams = [];
  final List players = [
    Players(
      name: "Syed Farazuddin",
      id: 1,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Shaik Anjum",
      id: 2,
      image: "http://surl.li/vaenjj",
    ),
    Players(
      name: "Rabada",
      id: 3,
      image: "http://surl.li/upxncu",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 9,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 8,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 4,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 5,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 6,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 7,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 10,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 11,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 12,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Syed Farazuddin",
      id: 13,
      image: "http://surl.li/glzedz",
    ),
  ];
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
                  setState(() {
                    selectedTeam = val;
                    teamSelected = true;
                  });
                })
            : SelectTeamPlayer(
                controller: _controller,
                players: players,
                teamName: teamSelected
                    ? yourTeams[selectedTeam].toString()
                    : "Team not Selected",
                selectedPlayers: widget.selectedPlayers as List<int>,
              ),
      ),
    );
  }

  Future<void> fetchYourTeams() async {
    final res =
        await ref.read(startMatchControllerProvider.notifier).fetchYourTeams();
    setState(() {
      yourTeams = res as List;
    });
  }
}
