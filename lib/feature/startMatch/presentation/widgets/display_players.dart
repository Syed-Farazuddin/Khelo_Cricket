import 'package:crick_hub/common/widgets/player_card.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayPlayers extends ConsumerStatefulWidget {
  const DisplayPlayers({
    super.key,
    required this.data,
    required this.selectBatman,
    required this.onTap,
    this.previousBowlerId = 0,
    this.showTeamAllPlayers = false,
  });
  final MatchData data;
  final bool selectBatman;
  final Function(Players) onTap;
  final int? previousBowlerId;
  final bool showTeamAllPlayers;
  @override
  ConsumerState<DisplayPlayers> createState() => _DisplayPlayersState();
}

class _DisplayPlayersState extends ConsumerState<DisplayPlayers> {
  @override
  Widget build(BuildContext context) {
    final Team teamA = ref.read(selectedTeamA);
    final Team teamB = ref.read(selectedTeamB);
    final Team team;
    if (widget.data.tossWonTeamId == teamA.teamId) {
      if (widget.selectBatman && widget.data.chooseToBat!) {
        team = teamA;
      } else {
        team = teamB;
      }
    } else {
      if (widget.selectBatman && widget.data.chooseToBat!) {
        team = teamB;
      } else {
        team = teamA;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: widget.selectBatman
            ? const Text("Select Batsman")
            : const Text("Select Bowler"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: ListView.separated(
          itemBuilder: (builder, index) {
            final Players currPlayer = team.players[index];
            if ((widget.showTeamAllPlayers)) {
              (team.selectedPlayers.contains(currPlayer.id))
                  ? PlayerCard(
                      player: currPlayer,
                      onTap: () {
                        widget.onTap(currPlayer);
                      },
                      color: Colors.white.withOpacity(0.2),
                      borderColor: Colors.white,
                    )
                  : const SizedBox.shrink();
            }

            return currPlayer.id != widget.previousBowlerId
                ? PlayerCard(
                    player: currPlayer,
                    onTap: () => widget.onTap(currPlayer),
                    color: Colors.white.withOpacity(0.2),
                    borderColor: Colors.white,
                  )
                : const SizedBox.shrink();
          },
          separatorBuilder: (builder, index) =>
              team.selectedPlayers.contains(team.players[index].id)
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox.shrink(),
          itemCount: teamB.players.length,
        ),
      ),
    );
  }
}
