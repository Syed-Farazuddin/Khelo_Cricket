import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoringPage extends ConsumerStatefulWidget {
  const ScoringPage({
    super.key,
    required this.data,
  });
  final MatchData data;

  @override
  ConsumerState<ScoringPage> createState() => _ScoringPageState();
}

class _ScoringPageState extends ConsumerState<ScoringPage> {
  @override
  Widget build(BuildContext context) {
    List<ScoringModel> scoringData = [
      ScoringModel(name: '1', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: '2', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: '3', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: '4', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: '6', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: 'WD', url: '/matches/${widget.data.id}/scoring/'),
      ScoringModel(name: 'NB', url: '/matches/${widget.data.id}/scoring/'),
    ];
    return Scaffold(
      appBar: AppBar(),
      // Top body should contains the match details score bowler and strikers
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Faraz 11 VS Mighty Marvericks",
                            style: GoogleFonts.golosText(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "24 May,2024",
                            style: GoogleFonts.golosText(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // The bottom should contain the scoring card where we can manually enter score and all.
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: GridView.builder(
                  itemCount: scoringData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (builder, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.2,
                        ),
                      ),
                      child: Text(
                        scoringData[index].name,
                        style: GoogleFonts.golosText(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateScore() async {}

  Future<void> fetchInningsData() async {}

  Future<void> chooseBatsman() async {}

  Future<void> changeBowler() async {}
}

class ScoringModel {
  String? url;
  String name;
  ScoringModel({
    required this.name,
    required this.url,
  });
}
