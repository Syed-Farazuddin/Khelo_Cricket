import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:flutter/material.dart';

class MatchScorecard extends StatelessWidget {
  const MatchScorecard({
    super.key,
    required this.matchId,
  });

  final int matchId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        "Scorecard",
        style: CustomTextStyles.large,
      ),
    );
  }
}
