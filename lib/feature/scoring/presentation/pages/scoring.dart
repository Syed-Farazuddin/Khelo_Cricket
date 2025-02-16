import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/common/models/scoring_models.dart';
import 'package:crick_hub/common/providers/scoring_provider.dart';
import 'package:crick_hub/common/routes/routes.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/common/widgets/pop_up.dart';
import 'package:crick_hub/common/widgets/square_field.dart';
import 'package:crick_hub/core/colors/colors.dart';
import 'package:crick_hub/feature/match/presentation/widgets/match_app_bar.dart';
import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/scoring/presentation/pages/choose_player.dart';
import 'package:crick_hub/feature/scoring/presentation/provider/scoring_provider.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_batsman.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
  late InningsModel inningsData = InningsModel(
    byes: 0,
    extras: 0,
    inningsid: 0,
    isCompleted: false,
    nonStrikerId: 0,
    wickets: 0,
    oversPlayed: 0,
    strikerId: 0,
    totalNoBalls: 0,
    totalRuns: 0,
    totalWides: 0,
    nonStriker: PlayerScoreModel(
      player: Players(name: '', id: 0),
      score: ScoreModel(),
    ),
    striker: PlayerScoreModel(
      player: Players(name: '', id: 0),
      score: ScoreModel(),
    ),
    batting: TeamData(name: '', id: 0),
    bowling: TeamData(name: '', id: 0),
    bowlerId: 0,
    bowler: PlayerBowlerScoreModel(
      player: Players(name: '', id: 0),
      score: BowlingScoreModel(),
    ),
  );
  bool loading = false;
  bool endInnings = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      loading = true;
    });
    await fetchInningsData(matchData: widget.data);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) const Loader();
    final currentBowler = ref.watch(currentBowlerProvider);
    final matchData = ref.watch(currentMatchProvider);
    int oversBowled = 0;
    if (!loading) {
      oversBowled = inningsData.bowler!.score!.over.length - 1;
    }
    List<WicketData> wicketList = [
      WicketData(
        asset: '${Constants.assetSvgpath}bowled.svg',
        name: 'Bowled',
        onclick: () {
          debugPrint("Bowled !!!! ");
          isWicket(
            matchData: widget.data,
            currentBowler: currentBowler,
            isBowled: true,
            bowlerId: currentBowler.id ?? 0,
          );
        },
      ),
      WicketData(
        asset: '${Constants.assetSvgpath}catchout.svg',
        name: 'Catch out',
        onclick: () {
          debugPrint("It's Catch out ");
          isWicket(
            matchData: widget.data,
            currentBowler: currentBowler,
            isCatchOut: true,
            fielderId: 1,
            bowlerId: currentBowler.id ?? 0,
          );
        },
      ),
      WicketData(
        asset: '${Constants.assetSvgpath}runout.svg',
        name: 'Run Out',
        onclick: () {
          debugPrint("Run Out .....");
          isWicket(
            isRunOut: true,
            matchData: widget.data,
            currentBowler: currentBowler,
            fielderId: 1,
            fielder1Id: 2,
            bowlerId: currentBowler.id ?? 0,
          );
        },
      ),
      WicketData(
        asset: '${Constants.assetSvgpath}caughtAndBowled.svg',
        name: 'Catch and bowl',
        onclick: () {
          debugPrint("It's Catch and bowl  ");
          isWicket(
            isCatchAndBowl: true,
            matchData: widget.data,
            currentBowler: currentBowler,
            bowlerId: currentBowler.id ?? 0,
          );
        },
      ),
      WicketData(
        asset: '${Constants.assetSvgpath}keepercatch.svg',
        name: 'Keeper Catch',
        onclick: () {
          debugPrint("keeper Catch");
          isWicket(
            isKeeperCatch: true,
            matchData: widget.data,
            currentBowler: currentBowler,
            keeperId: 1,
            bowlerId: currentBowler.id ?? 0,
          );
        },
      )
    ];
    List<ScoringModel> scoringData = [
      ScoringModel(
        name: '0',
      ),
      ScoringModel(
        name: '1',
      ),
      ScoringModel(
        name: '2',
      ),
      ScoringModel(
        name: '3',
      ),
      ScoringModel(
        name: '4',
      ),
      ScoringModel(
        name: '6',
      ),
      ScoringModel(
        name: '5,7',
      ),
      ScoringModel(
        name: 'Undo',
        isUndo: true,
        isColored: true,
      ),
      ScoringModel(
        name: 'W',
        isWicket: true,
        isColored: true,
      ),
      ScoringModel(
        name: 'WD',
        isWide: true,
        isColored: true,
      ),
      ScoringModel(
        name: 'NB',
        isColored: true,
        isNoBall: true,
      ),
      ScoringModel(
        name: 'NB',
        isColored: true,
        isNoBall: true,
      ),
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: "title",
        match: widget.data,
      ),
      body: loading
          ? const Loader()
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${matchData.state}",
                                style: GoogleFonts.golosText(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${matchData.ground}",
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${inningsData.totalRuns} / ${inningsData.wickets}",
                              style: CustomTextStyles.largeText,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            oversBowled > 0
                                ? Text(
                                    "( ${inningsData.oversPlayed} .${inningsData.bowler!.score!.over[oversBowled - 1 < 0 ? 0 : oversBowled - 1].length} )",
                                    style: CustomTextStyles.largeText,
                                  )
                                : const SizedBox.shrink(),
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 14,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.whitish,
                          ),
                          child: Column(
                            children: [
                              showBowler(bowler: inningsData.bowler!),
                              const SizedBox(
                                height: 15,
                              ),
                              overDetails(bowler: inningsData.bowler!),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          child: Text(
                            "${inningsData.status}",
                            style: CustomTextStyles.mediumText,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          child: Text(
                            "Overs Remaining : ${(matchData.overs ?? 0) - (inningsData.oversPlayed ?? 0)}",
                            style: CustomTextStyles.mediumText,
                          ),
                        ),
                      ],
                    ),
                    // The bottom should contain the scoring card where we can manually enter score and all.
                    scoringBaord(
                      currentBowler: currentBowler,
                      matchData: matchData,
                      scoringData: scoringData,
                      wicketList: wicketList,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget scoringBaord({
    required List<ScoringModel> scoringData,
    required List<WicketData> wicketList,
    required MatchData matchData,
    required BowlerDetails currentBowler,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: GridView.builder(
        itemCount: scoringData.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemBuilder: (builder, index) {
          return GestureDetector(
            onTap: () {
              if (scoringData[index].isWicket ?? false) {
                showWicketDialog(
                  wicketList: wicketList,
                );
              } else if (scoringData[index].isUndo ?? false) {
                undoScoreDialog();
              } else if (scoringData[index].isWide ?? false) {
                wideDialog();
              } else if (scoringData[index].name == '5,7') {
                multiRunsDialog(
                  matchData: matchData,
                  currentbowler: currentBowler,
                );
              } else {
                updateScore(
                  score: scoringData[index],
                  inningsId: matchData.firstInnings?.isCompleted ?? false
                      ? matchData.inningsB
                      : matchData.inningsA,
                  matchData: matchData,
                  wicketInfo: WicketModel(
                    bowlerId: currentBowler.id ?? 0,
                  ),
                  currentBowler: currentBowler,
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.07,
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
    );
  }

  wideDialog() {
    List<String> scores = ['1', '2', '3', '4', '5'];
    showModalBottomSheet(
      context: context,
      builder: (builder) => Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              "Wide",
              style: CustomTextStyles.large,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (builder, index) {
                  return Container(
                    height: 30,
                    width: 30,
                    color: Colors.blue.withValues(alpha: 0.4),
                    alignment: Alignment.center, // Centers text
                    child: Text(
                      scores[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                      ), // Reduce font size to fit
                    ),
                  );
                },
                separatorBuilder: (builder, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: scores.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  undoScoreDialog() {
    showModalBottomSheet(
      context: context,
      builder: (builder) => SafeArea(
        minimum: const EdgeInsets.only(top: 50),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 300,
          child: Column(
            children: [
              Text(
                "Are you sure you want undo ?",
                style: CustomTextStyles.large,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Custombutton(
                      onTap: () {},
                      title: 'Yes',
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Custombutton(
                      onTap: () {},
                      title: 'No',
                      width: 100,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  multiRunsDialog({
    required MatchData matchData,
    required BowlerDetails currentbowler,
  }) {
    TextEditingController runsController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      builder: (builder) => Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 18,
        ),
        child: Column(
          children: [
            Text(
              "Runs Scored",
              style: CustomTextStyles.large,
            ),
            const SizedBox(
              height: 20,
            ),
            SquareInputField(
              controller: runsController,
            ),
            const SizedBox(
              height: 20,
            ),
            Custombutton(
              onTap: () {
                updateScore(
                  score: ScoringModel(
                    name: runsController.text,
                  ),
                  wicketInfo: WicketModel(
                    bowlerId: currentbowler.id ?? 0,
                  ),
                  inningsId: matchData.firstInnings?.isCompleted ?? false
                      ? matchData.inningsB
                      : matchData.inningsA,
                  matchData: matchData,
                  currentBowler: currentbowler,
                );
                Navigator.pop(context);
              },
              // color: Colors.blue,
              title: "Update",
              width: 100,
            ),
          ],
        ),
      ),
    );
  }

  showWicketDialog({
    required List<WicketData> wicketList,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        // color: Colors.grey[400],
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: wicketList[index].onclick,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    wicketList[index].asset ?? '',
                    height: MediaQuery.of(context).size.height / 12,
                    colorFilter: const ColorFilter.mode(
                      Colors.white, // Desired color
                      BlendMode.srcIn, // Blend mode for applying the color
                    ),
                    width: 50,
                  ),
                ),
                Text(
                  wicketList[index].name ?? '',
                  style: CustomTextStyles.mediumText,
                ),
              ],
            ),
          ),
          itemCount: wicketList.length,
        ),
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
    List<BallModel> over = [];
    if (oversBowled > 0) {
      over = bowler.score!.over[oversBowled - 1];
    }
    if (over.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
        ),
        child: Text(
          "Yet to Bowl",
          style: CustomTextStyles.large,
        ),
      );
    }
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
          bool isWicket = over[idx].isWicket ?? false;
          return Container(
            height: 40,
            width: 40,
            // padding: EdgeInsets.symmetric(vertical: 6, horizontal: ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isWicket
                  ? Colors.red[900]
                  : runs <= 3
                      ? AppColors.dark.withValues(alpha: 0.2)
                      : const Color.fromARGB(255, 38, 109, 40),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isWicket ? "W" : runs.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.golosText(
                color: isWicket
                    ? Colors.white
                    : runs <= 3
                        ? Colors.white.withValues(alpha: 0.8)
                        : Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          );
        },
        itemCount: over.length,
      ),
    );
  }

  Widget showBowler({required PlayerBowlerScoreModel bowler}) {
    final over = bowler.score!.over;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
                    Constants.bowler,
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
        ),
        over.isNotEmpty
            ? Text(
                '${over.length - 1}.${over[over.length - 1].length}',
                style: CustomTextStyles.large,
              )
            : const Text(''),
      ],
    );
  }

  Widget batsman({
    required PlayerScoreModel player,
    bool isStriker = false,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.subBackground.withValues(alpha: 0.7),
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
            const SizedBox(
              width: 6,
            ),
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
                  "${player.score!.totalRuns} (${player.score!.runsScores!.isNotEmpty ? player.score!.runsScores!.length : 0})",
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
    bool isWicket = false,
    required ScoringModel score,
    required int? inningsId,
    WicketModel? wicketInfo,
    required MatchData matchData,
    required BowlerDetails currentBowler,
  }) async {
    final currentOver = ref.read(currentOverProvider);
    final updateScoring = Updatescoring(
      ball: 0,
      bowlerId: currentBowler.playerId,
      isBye: score.isBye ?? false,
      isNoBall: score.isNoBall ?? false,
      isWide: score.isWide ?? false,
      isRunOut: false,
      isWicket: isWicket,
      overId: currentOver.id,
      wicketInfo: wicketInfo,
      runs: int.parse(score.name),
    );
    final res = await ref
        .read(
          scoringProviderProvider.notifier,
        )
        .updateScoring(
          scoring: updateScoring,
          inningsId: inningsId!,
        );
    if (res.selectNewBowler ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => ChoosePlayer(
            selectBatman: false,
            previousPlayerId: currentBowler.id ?? 0,
            data: matchData,
            onTap: (player) => changeBowler(
              bowler: player,
              matchData: matchData,
              currentBowler: currentBowler,
            ),
          ),
        ),
      );
    }
    if (res.selectNewBatsman ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => ChoosePlayer(
            selectBatman: true,
            previousPlayerId: currentBowler.id ?? 0,
            data: matchData,
            onTap: (player) {
              updateBatsman(
                currentBatsmanid: inningsData.strikerId ?? 0,
                batsman: player,
                matchData: matchData,
              );
              fetchInningsData(matchData: matchData);
            },
          ),
        ),
      );
    }
    if (res.endInnings ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopUp(
            label: "End Innings",
            onTap: () {
              endMyInnings(matchData: matchData);
            },
          );
        },
      );
    }
    if (res.endMatch ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopUp(
            label: "End Match",
            onTap: () {
              endMatch(matchData: matchData);
            },
          );
        },
      );
    }
    fetchInningsData(matchData: matchData);
  }

  Future<void> endMatch({
    required MatchData matchData,
  }) async {
    final result = await ref.watch(scoringProviderProvider.notifier).endMatch(
          matchId: matchData.id ?? 0,
        );
    debugPrint(result.toString());

    if (result) {
      Routes().navigateToNewPage(context, 'matchDetails', matchData);
    }
  }

  Future<void> updateBatsman({
    required int currentBatsmanid,
    required Players batsman,
    required MatchData matchData,
  }) async {
    ref.read(scoringProviderProvider.notifier).updateBatsman(
          currentBatsmanid: currentBatsmanid,
          inningsId: inningsData.inningsid ?? 0,
          batsman: batsman,
        );
    context.pop();
    fetchInningsData(matchData: matchData);
  }

  Future<void> fetchInningsData({required MatchData matchData}) async {
    final currentInningsId = matchData.firstInnings?.isCompleted ?? false
        ? matchData.secondInnings?.inningsid ?? 0
        : matchData.firstInnings?.inningsid ?? 0;
    final data =
        await ref.read(scoringProviderProvider.notifier).getInningsData(
              inningsId: currentInningsId,
            );
    if (data.strikerId == 0) {
      ref.read(currentMatchProvider.notifier).state = matchData;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => const SelectBatsman(),
        ),
      );
    }
    setState(() {
      inningsData = data;
    });
  }

  Future<void> chooseBatsmans() async {}

  Future<void> isWicket({
    bool isRunOut = false,
    bool isBowled = false,
    int fielderId = 0,
    int fielder1Id = 0,
    int bowlerId = 0,
    int keeperId = 0,
    int wicketkeeperId = 0,
    int score = 0,
    bool isCatchOut = false,
    bool catchAndBowl = false,
    bool isCatchAndBowl = false,
    bool isKeeperCatch = false,
    required MatchData matchData,
    required BowlerDetails currentBowler,
  }) async {
    WicketModel wicketInfo = WicketModel(
      bowlerId: currentBowler.playerId ?? 0,
      fielder1Id: fielder1Id,
      fielderId: fielderId,
      isCatchOut: isCatchOut,
      isKeeperCatch: isKeeperCatch,
      isRunOut: isRunOut,
      keeperId: keeperId,
      isBowled: isBowled,
      isCatchAndBowl: isCatchAndBowl,
    );
    updateScore(
      score: ScoringModel(
        name: score.toString(),
      ),
      wicketInfo: wicketInfo,
      isWicket: true,
      inningsId: matchData.firstInnings?.isCompleted ?? false
          ? matchData.inningsB
          : matchData.inningsA,
      matchData: matchData,
      currentBowler: currentBowler,
    );
  }

  Future<void> endMyInnings({
    required MatchData matchData,
  }) async {
    final result =
        await ref.watch(startMatchControllerProvider.notifier).startNewInnings(
              request: StartNewInnings(
                inningsId: inningsData.inningsid ?? 0,
              ),
            );
    debugPrint(result.toString());

    ref.read(currentMatchProvider.notifier).state = result;
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => const SelectBatsman(),
      ),
    );
    // Refresh the data of the match
  }

  Future<void> changeBowler({
    required Players bowler,
    required BowlerDetails currentBowler,
    required MatchData matchData,
  }) async {
    final result =
        await ref.watch(startMatchControllerProvider.notifier).selectBowler(
              bowler: bowler,
              inningsId: inningsData.inningsid ?? 0,
              order: currentBowler.order ?? 0 + 1,
            );
    ref.watch(currentBowlerProvider.notifier).state = result.bowler;
    ref.watch(currentOverProvider.notifier).state = result.over;
    fetchInningsData(matchData: matchData);
  }
}

class ScoringModel {
  String name;
  bool? isWide;
  bool? isNoBall;
  bool? isBye;
  bool? isUndo;
  bool? isWicket;
  bool? isColored;
  ScoringModel({
    required this.name,
    this.isNoBall,
    this.isWide,
    this.isColored,
    this.isBye,
    this.isUndo,
    this.isWicket = false,
  });
}
