import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowSelectTeam extends StatefulWidget {
  final List yourTeams;
  const ShowSelectTeam({
    super.key,
    required this.yourTeams,
    required this.selectTeam,
    required this.selectedTeam,
  });
  final int selectedTeam;
  final Function(int value) selectTeam;
  @override
  State<ShowSelectTeam> createState() => _ShowSelectTeamState();
}

class _ShowSelectTeamState extends State<ShowSelectTeam> {
  late int selectedTeam;
  @override
  void initState() {
    super.initState();
    selectedTeam = widget.selectedTeam;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select your Team",
            style: GoogleFonts.golosText(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: widget.yourTeams.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (builder, index) {
              return GestureDetector(
                onTap: () => widget.selectTeam(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: index == selectedTeam
                        ? Colors.blue
                        : Colors.white.withOpacity(
                            0.18,
                          ),
                    border: Border.all(
                      color: Colors.white.withOpacity(
                        0.6,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.yourTeams[index],
                      style: GoogleFonts.golosText(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Add new Team",
            style: GoogleFonts.golosText(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
