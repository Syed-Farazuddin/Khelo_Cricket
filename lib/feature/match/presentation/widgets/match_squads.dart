import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/common/widgets/player_card.dart';
// import 'package:crick_hub/common/widgets/squads.dart';
import 'package:crick_hub/feature/match/domain/match_models.dart';
import 'package:crick_hub/feature/match/presentation/providers/match_detail_controller.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchSquads extends ConsumerStatefulWidget {
  const MatchSquads({
    super.key,
    required this.matchId,
  });
  final int matchId;

  @override
  ConsumerState<MatchSquads> createState() => _MatchSquadsState();
}

class _MatchSquadsState extends ConsumerState<MatchSquads> {
  bool loading = false;
  late MatchOverviewModel data = MatchOverviewModel();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    loading = true;
    await fetchMatchSquads();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loader()
        : Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Squads",
                  style: CustomTextStyles.heading,
                ),
                const SizedBox(
                  height: 30,
                ),
                // Squads(
                //   showSelectedPlayers: false,
                //   teamA: data.firstInnings!.batting?.name ?? "",
                //   teamAPlayers: data.firstInnings!.batting?.playing ?? [],
                //   teamB: data.firstInnings!.bowling?.name ?? "",
                //   teamBPlayers: data.firstInnings!.bowling?.playing ?? [],
                // ),
                showSquads(
                  teamName: data.firstInnings!.batting?.name ?? '',
                  squads: data.firstInnings!.batting!.playing,
                ),
                const SizedBox(
                  height: 20,
                ),
                showSquads(
                  teamName: data.firstInnings!.bowling?.name ?? '',
                  squads: data.firstInnings!.bowling!.playing,
                )
              ],
            ),
          );
  }

  Widget showSquads({
    required String teamName,
    required List<Players> squads,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teamName,
          style: CustomTextStyles.subheadings,
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (builder, index) {
            return PlayerCard(
              player: squads[index],
              onTap: () {},
              color: Colors.black.withValues(alpha: 0.19),
              borderColor: Colors.black.withValues(alpha: 0.2),
              showSelectPlayerIcon: false,
            );
          },
          separatorBuilder: (builder, idx) => const SizedBox(
            height: 10,
          ),
          itemCount: squads.length,
        ),
      ],
    );
  }

  Future<void> fetchMatchSquads() async {
    loading = true;
    final result = await ref
        .read(matchDetailControllerProvider.notifier)
        .fetchMatchOverview(matchId: widget.matchId);
    setState(() {
      loading = false;
      data = result;
    });
    debugPrint(result.toString());
    debugPrint("This is match overview");
  }
}
