import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/feature/match/presentation/pages/match_details.dart';
import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowMatches extends StatefulWidget {
  const ShowMatches({
    super.key,
    required this.matches,
  });
  final List<MatchData> matches;
  @override
  State<ShowMatches> createState() => _ShowMatchesState();
}

class _ShowMatchesState extends State<ShowMatches> {
  List<MatchData> matches = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    matches = widget.matches;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchDetails(
                  match: match,
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
                color: Colors.grey.withValues(alpha: 0.17),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: Text(
                        match.status.toString(),
                        style: CustomTextStyles.subheadings,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
                "${details.totalRuns} / ${details.wickets}",
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
}
