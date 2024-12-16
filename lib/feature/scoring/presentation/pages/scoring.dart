import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/scoring/presentation/provider/scoring_provider.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoringPage extends ConsumerStatefulWidget {
  const ScoringPage({
    super.key,
    required this.data,
  });
  final MatchData data;

  @override
  ConsumerState<ScoringPage> createState() => _ScoringPageState();
}

class _ScoringPageState extends ConsumerState<ScoringPage> {
  late InningsModel inningsData;

  @override
  void initState() {
    super.initState();
    fetchInningsData();
  }

  @override
  Widget build(BuildContext context) {
    List<ScoringModel> scoringData = [
      ScoringModel(name: '1', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: '2', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: '3', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: '4', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: '6', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(
        name: 'Undo',
        url: '/matches/${widget.data.id}/scoring/',
        isUndo: true,
      ),
      ScoringModel(
        name: 'WD',
        url: '/matches/${widget.data.id}/scoring/',
        isWide: true,
      ),
      ScoringModel(
          name: 'NB',
          url: '/matches/${widget.data.id}/scoring/',
          isNoBall: true),
      ScoringModel(
          name: 'NB',
          url: '/matches/${widget.data.id}/scoring/',
          isNoBall: true),
    ];
    return Scaffold(
      appBar: AppBar(),
      // Top body should contains the match details score bowler and strikers
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.data.state}",
                          style: GoogleFonts.golosText(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "${widget.data.ground}",
                          style: GoogleFonts.golosText(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${inningsData.totalRuns} Runs",
                        style: GoogleFonts.golosText(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "${inningsData.oversPlayed} Overs",
                        style: GoogleFonts.golosText(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  showBatsmans(
                    striker: inningsData.striker!,
                    nonStriker: inningsData.nonStriker!,
                  )
                ],
              ),
            ),
          ),
          // The bottom should contain the scoring card where we can manually enter score and all.
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: GridView.builder(
                itemCount: scoringData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (builder, index) {
                  return GestureDetector(
                    onTap: () {
                      updateScore(
                          score: scoringData[index],
                          inningsId: widget.data.inningsA);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.2,
                        ),
                      ),
                      child: Text(
                        scoringData[index].name,
                        style: GoogleFonts.golosText(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showBatsmans({required Players striker, required Players nonStriker}) {
    return Row(
      children: [
        player(
          player: striker,
          isStriker: true,
        ),
        const SizedBox(
          width: 8,
        ),
        player(
          player: nonStriker,
        ),
      ],
    );
  }

  Widget player({required Players player, bool isStriker = false}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(
            0.2,
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
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              height: 40,
              width: 40,
              child: Image.network(
                player.image ?? Constants.dummyImage,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${player.name} ${isStriker ? "*" : ""}",
              style: GoogleFonts.golosText(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateScore({
    required ScoringModel score,
    required int? inningsId,
  }) async {
    final updateScoring = Updatescoring(
      ball: 0,
      bowlerId: 1,
      isBye: score.isBye,
      isNoBall: score.isNoBall ?? false,
      isWide: score.isWide ?? false,
      isRunOut: false,
      isWicket: false,
      overId: 1,
      runs: int.parse(score.name),
    );
    await ref
        .watch(
          scoringProviderProvider.notifier,
        )
        .updateScoring(
          scoring: updateScoring,
          inningsId: inningsId!,
        );
    fetchInningsData();
  }

  Future<void> fetchInningsData() async {
    final currentInningsId = widget.data.firstInnings?.isCompleted ?? false
        ? widget.data.secondInnings?.inningsid ?? 0
        : widget.data.firstInnings?.inningsid ?? 0;
    final data =
        await ref.read(scoringProviderProvider.notifier).getInningsData(
              inningsId: currentInningsId,
            );
    setState(() {
      inningsData = data;
    });
  }

  Future<void> chooseBatsmans() async {}

  Future<void> changeBowler() async {}
}

class ScoringModel {
  String? url;
  String name;
  bool? isWide;
  bool? isNoBall;
  bool? isBye;
  bool? isUndo;
  ScoringModel({
    required this.name,
    this.isNoBall,
    this.isWide,
    this.isBye,
    this.isUndo,
    required this.url,
  });
}
