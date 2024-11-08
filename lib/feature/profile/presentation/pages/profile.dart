import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/feature/profile/data/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<List<StatsItem>> stats = [
    [
      StatsItem(name: "Matches", stats: "88"),
      StatsItem(name: "Innings", stats: "42"),
      StatsItem(name: "Runs", stats: "1442"),
      StatsItem(name: "NO", stats: "10"),
      StatsItem(name: "Balls", stats: "141"),
      StatsItem(name: "Highest", stats: "124"),
      StatsItem(name: "Average", stats: "41"),
      StatsItem(name: "Strike Rate", stats: "136.3"),
      StatsItem(name: "100s", stats: "3"),
      StatsItem(name: "50s", stats: "6"),
      StatsItem(name: "0s", stats: "9"),
      StatsItem(name: "Boundaries", stats: "34"),
      StatsItem(name: "Fours", stats: "28"),
      StatsItem(name: "Sixes", stats: "6"),
    ],
    [
      StatsItem(name: "Matches", stats: "24"),
      StatsItem(name: "Innings", stats: "18"),
      StatsItem(name: "Runs", stats: "152"),
      StatsItem(name: "Wickets", stats: "14"),
      StatsItem(name: "Average", stats: "17"),
      StatsItem(name: "Economy", stats: "7.2"),
      StatsItem(name: "Wides", stats: "9"),
      StatsItem(name: "No Balls", stats: "4"),
      StatsItem(name: "Best", stats: "6/18"),
      StatsItem(name: "3 Wickets", stats: "3"),
      StatsItem(name: "5 Wickets", stats: "6"),
      StatsItem(name: "Maidens", stats: "3"),
      StatsItem(name: "Boundaries", stats: "14"),
      StatsItem(name: "Fours", stats: "9"),
      StatsItem(name: "Sixes", stats: "5"),
    ],
    [
      StatsItem(name: "Matches", stats: "88"),
      StatsItem(name: "Innings", stats: "42"),
      StatsItem(name: "Run outs", stats: "8"),
      StatsItem(name: "Catches", stats: "30"),
      StatsItem(name: "Stumps", stats: "3"),
    ]
  ];
  int active = 0;
  List<String> fields = ["Batting", "Bowling", "Fielding"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "lib/assets/images/profile.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Syed Farazuddin",
                          style: GoogleFonts.golosText(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "21 years (24-05-2003)",
                          style: GoogleFonts.golosText(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "All Rounder",
                          style: GoogleFonts.golosText(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Right hand Bat",
                          style: GoogleFonts.golosText(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Right arm Medium",
                          style: GoogleFonts.golosText(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Stats",
                    style: GoogleFonts.golosText(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonList(
                    list: fields,
                    active: active,
                    onTap: (val) {
                      setState(
                        () {
                          active = val;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: stats[active].length,
                    itemBuilder: (builder, index) {
                      final StatsItem item = stats[active][index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.09),
                            ),
                            color: Colors.white.withOpacity(0.04)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.golosText(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              item.stats,
                              style: GoogleFonts.golosText(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget Fields({
  required String label,
  bool isActive = false,
  Function(bool value)? onTap,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 12,
    ),
    decoration: BoxDecoration(
      color: isActive
          ? Colors.grey.withOpacity(
              0.5,
            )
          : Colors.transparent,
      borderRadius: BorderRadius.circular(
        12,
      ),
    ),
    child: Text(
      label,
      style: GoogleFonts.golosText(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
