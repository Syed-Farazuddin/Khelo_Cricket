import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowPlayer extends StatelessWidget {
  const ShowPlayer({
    super.key,
    required this.player,
  });
  final Players player;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(
          alpha: 0.12,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                player.name.toString(),
                style: GoogleFonts.golosText(
                  fontSize: 16,
                ),
              ),
              if (player.isCaptain)
                const Text(
                  "(C)",
                )
            ],
          ),
          const Icon(
            Icons.arrow_right,
            size: 28,
          )
        ],
      ),
    );
  }
}
