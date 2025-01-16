import 'package:crick_hub/common/widgets/player_card.dart';
import 'package:crick_hub/feature/scoring/presentation/provider/scoring_provider.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
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
  List<Players> players = [];

  @override
  void initState() {
    fetchPlayers(
      inningsId: widget.data.firstInnings!.isCompleted ?? false
          ? widget.data.secondInnings!.inningsid ?? 0
          : widget.data.firstInnings!.inningsid ?? 0,
      batting: widget.selectBatman,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            final Players currPlayer = players[index];
            if (widget.showTeamAllPlayers) {
              PlayerCard(
                player: currPlayer,
                showSelectPlayerIcon: false,
                onTap: () {
                  widget.onTap(currPlayer);
                },
                color: Colors.white.withValues(
                  alpha: 0.2,
                ),
                borderColor: Colors.white,
              );
            }

            return currPlayer.id != widget.previousBowlerId
                ? PlayerCard(
                    player: currPlayer,
                    showSelectPlayerIcon: false,
                    onTap: () => widget.onTap(
                      currPlayer,
                    ),
                    color: Colors.white.withValues(
                      alpha: 0.2,
                    ),
                    borderColor: Colors.white,
                  )
                : const SizedBox.shrink();
          },
          separatorBuilder: (builder, index) => const SizedBox(
            height: 10,
          ),
          itemCount: players.length,
        ),
      ),
    );
  }

  Future<void> fetchPlayers({
    required int inningsId,
    required bool batting,
  }) async {
    final data = await ref
        .read(scoringProviderProvider.notifier)
        .getPlayingTeam(inningsId: inningsId, battingPlayers: batting);
    setState(() {
      players = data;
    });
  }
}
