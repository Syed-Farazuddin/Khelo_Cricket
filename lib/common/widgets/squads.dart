import 'package:crick_hub/common/widgets/show_player.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Squads extends StatefulWidget {
  const Squads({
    super.key,
    required this.teamA,
    required this.teamB,
    required this.teamAPlayers,
    required this.teamBPlayers,
    this.showSelectedPlayers = true,
  });
  final String teamA;
  final List<Players> teamAPlayers;
  final List<Players> teamBPlayers;
  final String teamB;
  final bool showSelectedPlayers;
  @override
  State<Squads> createState() => _SquadsState();
}

class _SquadsState extends State<Squads> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: showSquads(
            widget.teamA,
            widget.teamAPlayers,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: showSquads(
            widget.teamB,
            widget.teamBPlayers,
          ),
        ),
      ],
    );
  }

  Widget showSquads(String teamName, List<Players> players) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          teamName.toString(),
          style: GoogleFonts.golosText(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (builder, index) {
            return players[index].selected || !(widget.showSelectedPlayers)
                ? ShowPlayer(player: players[index])
                : const SizedBox.shrink();
          },
          separatorBuilder: (builder, index) => const SizedBox(
            height: 10,
          ),
          itemCount: players.length,
        ),
      ],
    );
  }
}
