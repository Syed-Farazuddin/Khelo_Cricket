import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/common/models/scoring_models.dart';
import 'package:crick_hub/common/providers/scoring_provider.dart';
import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/feature/Home/data/home_repository.dart';
import 'package:crick_hub/feature/match/presentation/pages/match_details.dart';
import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/scoring/presentation/pages/scoring.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int active = 0;
  bool loading = false;
  List<String> items = ["Completed", "Upcoming"];
  List<MatchData> matches = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      loading = true;
    });
    matches = await ref.read(homeRepositoryProvider).getYourMatches();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: loading
          ? const Loader()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Custombutton(
                            onTap: () {
                              context.pushNamed("/selectTeams");
                            },
                            width: MediaQuery.of(context).size.width / 2,
                            title: "Start Match",
                            icon: (Icons.add),
                            showIcon: true,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Custombutton(
                            width: MediaQuery.of(context).size.width / 2,
                            onTap: () {
                              context.goNamed("/startTournament");
                            },
                            title: "Start  tournament",
                            icon: (Icons.add),
                            showIcon: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Matches",
                    style: GoogleFonts.golosText(
                      fontSize: 24,
                      color: Colors.grey.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                    height: 30,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      final match = matches[index];
                      return GestureDetector(
                        onTap: () {
                          // if (match.scorerId == 1) {
                          //   return;
                          // }
                          ref.read(currentBowlerProvider.notifier).state =
                              BowlerDetails(id: 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScoringPage(
                                data: match,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              color: Colors.grey.withOpacity(0.17),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          match.ground.toString(),
                                        ),
                                        Text(
                                          match.state.toString(),
                                        ),
                                        // Text(match.state)
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    height: 1,
                                    thickness: 0.2,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  showTeam(
                                    details: match.firstInnings!,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  showTeam(
                                    details: match.secondInnings!,
                                  ),
                                  // const Divider(
                                  //   color: Colors.white,
                                  //   height: 1,
                                  //   thickness: 0.2,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    child: Text(match.status.toString()),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}

Widget showTeam({required InningsModel details}) {
  final headingStyle = GoogleFonts.golosText(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 12,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          details.batting?.name ?? '',
          style: headingStyle,
        ),
        Row(
          children: [
            Text(
              "${details.totalRuns} / ${details.extras}",
              style: headingStyle,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "(${details.oversPlayed})",
              style: headingStyle,
            ),
          ],
        ),
      ],
    ),
  );
}

showDialogBox({required BuildContext context, required MatchData match}) {
  return showDialog(
    context: context,
    builder: (builder) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Custombutton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScoringPage(
                      data: match,
                    ),
                  ),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MatchDetails(
                //       match: match,
                //     ),
                //   ),
                // );
              },
              title: "View Match Details",
              width: 200,
            ),
            Custombutton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScoringPage(
                      data: match,
                    ),
                  ),
                );
              },
              title: "Continue Scoring",
              width: 200,
            )
          ],
        ),
      ),
    ),
  );
}

enum Status {
  upcoming(0),
  completed(1),
  ongoing(2);

  final int value;

  const Status(this.value);

  // Helper method to map an integer from the backend to an enum
  static Status fromInt(int statusValue) {
    return Status.values.firstWhere(
      (e) => e.value == statusValue,
      orElse: () => Status.upcoming, // Default if no match is found
    );
  }
}
