import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/common/widgets/image.dart';
import 'package:crick_hub/core/colors/colors.dart';
import 'package:crick_hub/feature/match/domain/match_models.dart';
import 'package:crick_hub/feature/match/presentation/providers/match_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchScorecard extends ConsumerStatefulWidget {
  const MatchScorecard({
    super.key,
    required this.matchId,
  });

  final int matchId;

  @override
  ConsumerState<MatchScorecard> createState() => _MatchScorecardState();
}

class _MatchScorecardState extends ConsumerState<MatchScorecard> {
  late MatchOverviewModel data = MatchOverviewModel();
  bool loading = false;
  bool showFirstInnings = true;
  bool showSecondInnnigs = true;

  @override
  void initState() {
    super.initState();
    fetchMatchScorecard();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Loader(),
          ),
        ],
      );
    }
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Scorecard",
              style: CustomTextStyles.large,
            ),
            const SizedBox(
              height: 20,
            ),
            expandTile(
              team: data.firstInnings!.batting!,
              totalRuns: data.firstInnings!.totalRuns ?? 0,
              totalWicktets: data.firstInnings!.wickets ?? 0,
              expand: showFirstInnings,
            ),
            if (showFirstInnings)
              showInningsDetails(
                innings: data.firstInnings,
              ),
            const SizedBox(
              height: 20,
            ),
            expandTile(
              team: data.secondInnings!.batting!,
              expand: showSecondInnnigs,
              totalRuns: data.secondInnings!.totalRuns ?? 0,
              totalWicktets: data.secondInnings!.wickets ?? 0,
            ),
            if (showSecondInnnigs)
              showInningsDetails(
                innings: data.secondInnings,
              ),
          ],
        ),
      ),
    );
  }

  Widget showInningsDetails({required Innings? innings}) {
    List<BattingDetails> batsmens = innings!.batting!.batmens;
    List<BowlingDetails> bowlers = innings.bowling!.bowlers;
    debugPrint(bowlers.toString());
    return Column(
      children: [
        const SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Text(
                'Batters',
                style: CustomTextStyles.large,
              ),
            ),
            Text(
              'R',
              style: CustomTextStyles.large,
            ),
            Text(
              'B',
              style: CustomTextStyles.large,
            ),
            Text(
              "4s",
              style: CustomTextStyles.large,
            ),
            Text(
              "6s",
              style: CustomTextStyles.large,
            ),
            Text(
              "SR",
              style: CustomTextStyles.large,
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (builder, index) {
            BattingDetails batmen = batsmens[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.02,
                ),
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomImage(
                        image: batmen.player?.image ?? '',
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${batmen.player?.name ?? 'Player $index'} ${batmen.isOut ?? false ? "" : "*"}',
                        style: CustomTextStyles.large.copyWith(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    batmen.totalRuns.toString(),
                    style: CustomTextStyles.large.copyWith(
                      color: AppColors.subTitles,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    batmen.fours.toString(),
                    style: CustomTextStyles.large.copyWith(
                      color: AppColors.subTitles,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    batmen.fours.toString(),
                    style: CustomTextStyles.large.copyWith(
                      color: AppColors.subTitles,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    batmen.sixes.toString(),
                    style: CustomTextStyles.large.copyWith(
                      color: AppColors.subTitles,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    batmen.sixes.toString(),
                    style: CustomTextStyles.large.copyWith(
                      color: AppColors.subTitles,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, idx) => const SizedBox(
            height: 20,
          ),
          itemCount: batsmens.length,
        ),
      ],
    );
  }

  Widget expandTile({
    required Team team,
    required int totalRuns,
    required int totalWicktets,
    required bool expand,
  }) {
    return GestureDetector(
      onTap: () {
        expand = !expand;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              team.name ?? "Team A",
              style: CustomTextStyles.subheadings,
            ),
            Row(
              children: [
                Text(
                  "$totalRuns / $totalWicktets",
                  style: CustomTextStyles.subheadings,
                ),
                const SizedBox(
                  width: 20,
                ),
                Icon(
                  expand
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: AppColors.subTitles,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> fetchMatchScorecard() async {
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
