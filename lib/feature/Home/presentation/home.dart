import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/core/colors/colors.dart';
import 'package:crick_hub/feature/Home/presentation/widgets/matches_section.dart';
import 'package:crick_hub/feature/Home/presentation/widgets/tournament_section.dart';
import 'package:crick_hub/feature/scoring/presentation/pages/scoring.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int sublistActive = 0;
  int listActive = 0;
  List<String> items = ["Completed", "Upcoming"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: Custombutton(
                        onTap: () {
                          context.pushNamed("/selectTeams");
                        },
                        width: MediaQuery.of(context).size.width / 2,
                        title: "Start Match",
                        icon: (Icons.add),
                        color: Colors.grey.withValues(alpha: 0.18),
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: Custombutton(
                        width: MediaQuery.of(context).size.width / 2,
                        onTap: () {
                          context.pushNamed("/startTournament");
                        },
                        title: "Register tournament",
                        icon: (Icons.add),
                        color: Colors.grey.withValues(alpha: 0.18),
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 10),
              child: ButtonList(
                list: const ['Your Matches', "Tournaments"],
                onTap: (value) {
                  setState(() {
                    listActive = value;
                  });
                },
                activeColor: AppColors.green,
                active: listActive,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ButtonList(
                list: items,
                onTap: (val) {
                  setState(() {
                    sublistActive = val;
                  });
                },
                active: sublistActive,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            listActive == 0
                ? const MatchesSection()
                : const TournamentSection(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
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
