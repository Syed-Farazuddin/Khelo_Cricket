// import 'package:crick_hub/common/widgets/button_list.dart';
// import 'package:crick_hub/common/widgets/custom_button.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:crick_hub/common/widgets/custom_input.dart';
// import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/startMatch/data/models/models.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/select_team_player.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/show_select_team.dart';
import 'package:flutter/material.dart';

class SelectTeam extends StatefulWidget {
  const SelectTeam({
    super.key,
    required this.teamName,
    required this.selectedPlayers,
  });
  final String teamName;
  final List selectedPlayers;
  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> {
  bool teamSelected = false;
  List yourTeams = ["Rebel Warrios", "Falcons", "Bandlaguda Bulls"];
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
    )
  ];
  final TextEditingController _controller = TextEditingController();
  int selectedTeam = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: !teamSelected
            ? ShowSelectTeam(
                yourTeams: yourTeams,
                selectedTeam: selectedTeam,
              )
            : SelectTeamPlayer(
                controller: _controller,
                players: players,
                teamName: teamSelected ? "Team A" : "Team not Selected",
                selectedPlayers: widget.selectedPlayers as List<int>,
              ),
      ),
    );
  }
}
