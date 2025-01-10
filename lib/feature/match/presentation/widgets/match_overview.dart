import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/feature/match/presentation/providers/match_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crick_hub/feature/match/domain/match_models.dart';

class MatchOverview extends ConsumerStatefulWidget {
  const MatchOverview({
    super.key,
    required this.matchId,
  });

  final int matchId;

  @override
  ConsumerState<MatchOverview> createState() => _MatchOverviewState();
}

class _MatchOverviewState extends ConsumerState<MatchOverview> {
  bool loading = false;
  late MatchOverviewModel data = MatchOverviewModel();
  @override
  void initState() {
    fetchMatchOverview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loader()
        : Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      viewTeamScores(data.firstInnings!),
                      const SizedBox(
                        height: 10,
                      ),
                      viewTeamScores(data.secondInnings!),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    data.matchStatus ?? '',
                    style: CustomTextStyles.large.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[500],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget viewTeamScores(Innings innings) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          innings.batting!.name.toString(),
          textAlign: TextAlign.start,
          style: CustomTextStyles.large.copyWith(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${innings.totalRuns.toString()} / ${innings.totalNoBalls} ( ${innings.oversPlayed}.0 ) ',
              style: CustomTextStyles.large.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget rowText({required String? label1, required String? label2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label1 ?? '',
        ),
        Text(
          label2 ?? '',
        ),
      ],
    );
  }

  Future<void> fetchMatchOverview() async {
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
