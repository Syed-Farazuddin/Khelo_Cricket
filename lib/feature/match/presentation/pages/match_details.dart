import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/feature/match/presentation/providers/match_detail_controller.dart';
import 'package:crick_hub/feature/match/presentation/widgets/match_overview.dart';
import 'package:crick_hub/feature/match/presentation/widgets/match_scorecard.dart';
import 'package:crick_hub/feature/match/presentation/widgets/match_squads.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchDetails extends ConsumerStatefulWidget {
  const MatchDetails({
    required this.match,
    super.key,
  });
  final MatchData match;

  @override
  ConsumerState<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends ConsumerState<MatchDetails> {
  late List items = [];
  late List pages = [];

  int active = 0;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    fetchMatchOverview();
    fetchMatchDetailItems();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      MatchOverview(
        matchId: widget.match.id ?? 0,
      ),
      MatchScorecard(
        matchId: widget.match.id ?? 0,
      ),
      MatchSquads(
        matchId: widget.match.id ?? 0,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.match.firstInnings!.batting!.name} vs ${widget.match.firstInnings!.bowling!.name}',
          style: CustomTextStyles.large,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              ButtonList(
                list: items,
                onTap: (val) {
                  setState(() {
                    active = val;
                  });
                },
                active: active,
              ),
              const SizedBox(
                height: 20,
              ),
              widgets[active],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchMatchOverview() async {
    await ref
        .read(matchDetailControllerProvider.notifier)
        .fetchMatchOverview(matchId: widget.match.id ?? 0);
  }

  Future<void> fetchMatchDetailItems() async {
    final res = await ref
        .read(matchDetailControllerProvider.notifier)
        .fetchMatchDetailItems();
    setState(() {
      items = res;
    });
  }
}
