import 'package:crick_hub/common/widgets/batman_card.dart';
import 'package:crick_hub/common/widgets/bowler_card.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoosePlayer extends ConsumerStatefulWidget {
  const ChoosePlayer({
    super.key,
    required this.previousPlayerId,
    required this.selectBatman,
    required this.data,
  });
  final int previousPlayerId;
  final bool selectBatman;
  final MatchData data;
  @override
  ConsumerState<ChoosePlayer> createState() => _ChoosePlayerState();
}

class _ChoosePlayerState extends ConsumerState<ChoosePlayer> {
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
        title: Text(
          widget.selectBatman ? "Select new batsman" : "Select new Bowler",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemBuilder: (builder, index) {
            final player = team.players[index];
            if (!(widget.selectBatman)) {
              return team.selectedPlayers.contains(player.id)
                  ? BowlerCard(bowler: player)
                  : const SizedBox.shrink();
            }
            return const BatmanCard();
          },
          separatorBuilder: (builder, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: 6,
        ),
      ),
    );
  }
}
