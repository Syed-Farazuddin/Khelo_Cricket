import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final previousMatches = [
      Match(
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        state: "Telangana",
        scoreA: "180",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 0,
        overs: "20",
        scheduledAt: "Thrills Cricket Club, Moinabad",
        teamA: TeamDetails(
          name: "Faraz 11",
          dots: "20",
          fours: "10",
          overs: "18",
          score: "180",
          sixes: "4",
          status: "Won by 30 runs",
          wickets: "10",
          won: true,
        ),
        teamB: TeamDetails(
          name: "Anjum 11",
          dots: "20",
          fours: "10",
          overs: "20",
          score: "150",
          sixes: "4",
          status: "Loss by 30 runs",
          wickets: "6",
          won: false,
        ),
      ),
      Match(
        state: "Telangana",
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        scoreA: "180",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 1,
        overs: "20",
        scheduledAt: "One champions, Aziz Nagar",
        teamA: TeamDetails(
          name: "Faraz 11",
          dots: "20",
          fours: "10",
          overs: "8",
          score: "180",
          sixes: "4",
          status: "Won by 36 runs",
          wickets: "6",
          won: true,
        ),
        teamB: TeamDetails(
          name: "Faraz 11",
          dots: "20",
          fours: "10",
          overs: "8",
          score: "180",
          sixes: "4",
          status: "Won by 36 runs",
          wickets: "6",
          won: false,
        ),
      ),
      Match(
        scheduledAt: "Mythri Cricket Club, Hyderabad",
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        scoreA: "180",
        state: "Telangana",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 2,
        overs: "20",
        teamA: TeamDetails(
          name: "Faraz 11",
          dots: "20",
          fours: "10",
          overs: "8",
          score: "180",
          sixes: "4",
          status: "Won by 36 runs",
          wickets: "6",
          won: true,
        ),
        teamB: TeamDetails(
          dots: "20",
          name: "Faraz 11",
          fours: "10",
          overs: "8",
          score: "180",
          sixes: "4",
          status: "Won by 36 runs",
          wickets: "6",
          won: false,
        ),
      ),
      Match(
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        state: "Telangana",
        scoreA: "180",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 0,
        overs: "20",
        scheduledAt: "Thrills Cricket Club, Moinabad",
        teamA: TeamDetails(
          name: "Faraz 11",
          dots: "20",
          fours: "10",
          overs: "18",
          score: "180",
          sixes: "4",
          status: "Won by 30 runs",
          wickets: "10",
          won: true,
        ),
        teamB: TeamDetails(
          name: "Anjum 11",
          dots: "20",
          fours: "10",
          overs: "20",
          score: "150",
          sixes: "4",
          status: "Loss by 30 runs",
          wickets: "6",
          won: false,
        ),
      ),
      Match(
        state: "Telangana",
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        scoreA: "180",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 1,
        overs: "20",
        scheduledAt: "One champions, Aziz Nagar",
        teamA: TeamDetails(
          name: "Faraz 11",
          dots: "20",
          fours: "10",
          overs: "8",
          score: "180",
          sixes: "4",
          status: "Won by 36 runs",
          wickets: "6",
          won: true,
        ),
        teamB: TeamDetails(
          name: "Faraz 11",
          dots: "20",
          fours: "10",
          overs: "8",
          score: "180",
          sixes: "4",
          status: "Won by 36 runs",
          wickets: "6",
          won: false,
        ),
      ),
      Match(
        scheduledAt: "Mythri Cricket Club, Hyderabad",
        firstTeam: "Faraz 11",
        secondTeam: "Anjum 11",
        scoreA: "180",
        state: "Telangana",
        scoreB: "144",
        startedAt: "24th May,2024",
        matchStatus: "Faraz 11 won by 36 runs",
        status: 2,
        overs: "20",
        teamA: TeamDetails(
          name: "Faraz 11",
          dots: "20",
          fours: "10",
          overs: "8",
          score: "180",
          sixes: "4",
          status: "Won by 36 runs",
          wickets: "6",
          won: true,
        ),
        teamB: TeamDetails(
          dots: "20",
          name: "Faraz 11",
          fours: "10",
          overs: "8",
          score: "180",
          sixes: "4",
          status: "Won by 36 runs",
          wickets: "6",
          won: false,
        ),
      ),
    ];
    return Container(
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: previousMatches.length,
              itemBuilder: (context, index) {
                final match = previousMatches[index];
                return Padding(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(match.scheduledAt.toString()),
                                Text(match.startedAt.toString()),
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
                            details: match.teamA,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          showTeam(
                            details: match.teamB,
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
                            child: Text(match.matchStatus.toString()),
                          )
                        ],
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

Widget showTeam({required TeamDetails details}) {
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
          details.name,
          style: headingStyle,
        ),
        Row(
          children: [
            Text(
              "${details.score} / ${details.wickets}",
              style: headingStyle,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "(${details.overs})",
              style: headingStyle,
            ),
          ],
        ),
      ],
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
  String state;
  TeamDetails teamA;
  TeamDetails teamB;

  Match({
    required this.state,
    required this.firstTeam,
    required this.scoreA,
    required this.scoreB,
    required this.secondTeam,
    required this.startedAt,
    required this.status,
    required this.matchStatus,
    required this.scheduledAt,
    required this.overs,
    this.tossStatus,
    required this.teamA,
    required this.teamB,
  });
}

class TeamDetails {
  String name;
  String score;
  String overs;
  String dots;
  String fours;
  String sixes;
  String wickets;
  String status;
  bool won;

  TeamDetails({
    required this.name,
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
