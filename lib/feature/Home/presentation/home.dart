import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final headingStyle = GoogleFonts.golosText(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
    final previousMatches = [
      Match(
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        scoreA: "180",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 0,
        overs: "20",
      ),
      Match(
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        scoreA: "180",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 1,
        overs: "20",
      ),
      Match(
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        scoreA: "180",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 2,
        overs: "20",
      ),
    ];
    return Container(
      decoration: const BoxDecoration(),
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
                    onTap: () {},
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
                    onTap: () {},
                    title: "Start  tournament",
                    icon: (Icons.add),
                    showIcon: true,
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 30,
          // ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Your Previous Matches",
            style: GoogleFonts.golosText(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: previousMatches.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    color: Colors.grey.withOpacity(0.17),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                previousMatches[index].firstTeam ??
                                    "First Team",
                                style: headingStyle,
                              ),
                              Row(
                                children: [
                                  Text(
                                    previousMatches[index].scoreA ??
                                        "Score Team",
                                    style: headingStyle,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "(${previousMatches[index].overs})",
                                    style: headingStyle,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
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

class Match {
  String? firstTeam;
  String? secondTeam;
  String? scoreA;
  String? scoreB;
  String? startedAt;
  String? tossStatus;
  String? matchStatus;
  String? overs;
  String? scheduledAt;
  int status;

  Match({
    required this.firstTeam,
    required this.scoreA,
    required this.scoreB,
    required this.secondTeam,
    required this.startedAt,
    required this.status,
    required this.matchStatus,
    required this.overs,
    this.tossStatus,
  });
}

class TeamDetails {
  String score;
  String overs;
  String dots;
  String fours;
  String sixes;
  String wickets;
  String status;
  bool won;

  TeamDetails({
    required this.dots,
    required this.fours,
    required this.overs,
    required this.score,
    required this.sixes,
    required this.status,
    required this.wickets,
    required this.won,
  });
}
