import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowTeams extends StatelessWidget {
  const ShowTeams({
    super.key,
    required this.teams,
    required this.selectTeam,
    required this.selectedTeam,
  });
  final List<Team> teams;
  final Function(int idx) selectTeam;
  final int selectedTeam;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: teams.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (builder, index) {
        return GestureDetector(
          onTap: () => selectTeam(index),
          child: Container(
            decoration: BoxDecoration(
              color: index == selectedTeam
                  ? Colors.blue
                  : Colors.white.withValues(
                      alpha: 0.18,
                    ),
              border: Border.all(
                color: Colors.white.withValues(
                  alpha: 0.2,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                teams[index].name,
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
    );
  }
}
