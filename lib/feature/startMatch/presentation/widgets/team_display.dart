import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamDisplay extends StatefulWidget {
  final String label;
  final int teamNo;
  final List<Team> teams;
  final Function() onTap;
  final Color backgroundColor;
  const TeamDisplay({
    super.key,
    required this.label,
    required this.teamNo,
    required this.onTap,
    required this.teams,
    this.backgroundColor = Colors.white,
  });

  @override
  State<TeamDisplay> createState() => _TeamDisplayState();
}

class _TeamDisplayState extends State<TeamDisplay> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: widget.backgroundColor,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.golosText(
              color: widget.backgroundColor == Colors.blue
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
