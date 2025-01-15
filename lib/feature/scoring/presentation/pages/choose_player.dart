import 'package:crick_hub/common/widgets/batman_card.dart';
import 'package:crick_hub/common/widgets/bowler_card.dart';
import 'package:crick_hub/feature/scoring/presentation/provider/scoring_provider.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChoosePlayer extends ConsumerStatefulWidget {
  const ChoosePlayer({
    super.key,
    required this.previousPlayerId,
    required this.selectBatman,
    required this.data,
    required this.onTap,
  });
  final int previousPlayerId;
  final bool selectBatman;
  final MatchData data;
  final Function(Players) onTap;

  @override
  ConsumerState<ChoosePlayer> createState() => _ChoosePlayerState();
}

class _ChoosePlayerState extends ConsumerState<ChoosePlayer> {
  List<Players> players = [];

  void init() {
    fetchPlayers(
      batting: widget.selectBatman,
      inningsId: widget.data.firstInnings!.isCompleted ?? false
          ? widget.data.firstInnings!.inningsid ?? 0
          : widget.data.secondInnings!.inningsid ?? 0,
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
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
            final player = players[index];
            if (!(widget.selectBatman)) {
              return GestureDetector(
                onTap: () {
                  widget.onTap(player);
                },
                child: BowlerCard(
                  bowler: player,
                  onTap: widget.onTap,
                ),
              );
            }
            return BatmanCard(
              batsman: player,
              onTap: widget.onTap,
            );
          },
          separatorBuilder: (builder, index) {
            return const SizedBox(
              height: 10,
            );
          },
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
