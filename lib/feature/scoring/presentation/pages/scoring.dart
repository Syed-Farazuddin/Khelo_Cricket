import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/providers/scoring_provider.dart';
import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/scoring/presentation/provider/scoring_provider.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
  bool loading = false;
  bool selectNewBowler = false;

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
      body: loading
          ? LoadingAnimationWidget.bouncingBall(color: Colors.white, size: 30)
          : Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
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
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        showBatsmans(
                          striker: inningsData.striker!,
                          nonStriker: inningsData.nonStriker!,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        showBowler(bowler: inningsData.bowler!),
                        const SizedBox(
                          height: 6,
                        ),
                        overDetails(bowler: inningsData.bowler!),
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
                    child: GridView.builder(
                      itemCount: scoringData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                0.07,
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

  Widget showBatsmans({
    required PlayerScoreModel striker,
    required PlayerScoreModel nonStriker,
  }) {
    return Row(
      children: [
        batsman(
          player: striker,
          isStriker: true,
        ),
        const SizedBox(
          width: 8,
        ),
        batsman(
          player: nonStriker,
        ),
      ],
    );
  }

  Widget overDetails({required PlayerBowlerScoreModel bowler}) {
    int oversBowled = bowler.score!.over.length;
    List<BallModel> over = bowler.score!.over[oversBowled - 1];
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (builder, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (builder, idx) {
          int runs = over[idx].runs ?? 0;
          return Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: runs <= 3 ? Colors.white.withOpacity(0.54) : Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              runs.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.golosText(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        itemCount: over.length,
      ),
    );
  }

  Widget showBowler({required PlayerBowlerScoreModel bowler}) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            fit: BoxFit.cover,
            bowler.player?.image ?? Constants.dummyImage,
            height: 40,
            width: 40,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'lib/assets/images/bowler.png',
                height: 40,
                width: 40,
              ); // Your fallback image
            },
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          bowler.player?.name ?? "",
          style: GoogleFonts.golosText(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget batsman({required PlayerScoreModel player, bool isStriker = false}) {
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
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  50,
                ),
              ),
              padding: const EdgeInsets.all(6),
              height: 60,
              width: 50,
              child: ClipOval(
                child: Image.network(
                  player.player?.image ?? Constants.dummyImage,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/assets/images/cricket.jpg',
                      height: 40,
                      width: 40,
                    ); // Your fallback image
                  },
                ),
              ),
            ),
            // const SizedBox(
            //   width: 15,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${player.player!.name} ${isStriker ? "*" : ""}",
                  style: GoogleFonts.golosText(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${player.score!.totalRuns} (${player.score!.runsScores!.length})",
                  style: GoogleFonts.golosText(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
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
    final currentBowler = ref.read(currentBowlerProvider);
    final currentOver = ref.read(currentOverProvider);
    final updateScoring = Updatescoring(
      ball: 0,
      bowlerId: currentBowler.id,
      isBye: score.isBye,
      isNoBall: score.isNoBall ?? false,
      isWide: score.isWide ?? false,
      isRunOut: false,
      isWicket: false,
      overId: currentOver.id,
      runs: int.parse(score.name),
    );
    final res = await ref
        .watch(
          scoringProviderProvider.notifier,
        )
        .updateScoring(
          scoring: updateScoring,
          inningsId: inningsId!,
        );
    setState(() {
      selectNewBowler = res.selectNewBowler ?? false;
    });
    fetchInningsData();
  }

  Future<void> fetchInningsData() async {
    loading = true;
    final currentInningsId = widget.data.firstInnings?.isCompleted ?? false
        ? widget.data.secondInnings?.inningsid ?? 0
        : widget.data.firstInnings?.inningsid ?? 0;
    final data =
        await ref.read(scoringProviderProvider.notifier).getInningsData(
              inningsId: currentInningsId,
            );
    setState(() {
      inningsData = data;
      loading = false;
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
