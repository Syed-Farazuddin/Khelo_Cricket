import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/providers/scoring_provider.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/scoring/presentation/pages/scoring.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/show_roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectBowler extends ConsumerStatefulWidget {
  const SelectBowler({
    super.key,
    // required this.data,
    this.previousBowlerId = 0,
  });
  // final MatchData data;
  final int previousBowlerId;
  @override
  ConsumerState<SelectBowler> createState() => _SelectBowlerState();
}

class _SelectBowlerState extends ConsumerState<SelectBowler> {
  late final MatchData data;

  @override
  void initState() {
    super.initState();
    // data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final MatchData data = ref.watch(currentMatchProvider);
    Players bowler = Players(name: '', id: 0);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Bowler",
          style: GoogleFonts.golosText(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowRoles(
              ontap: (player) {
                bowler = player;
                context.pop();
              },
              role: bowler.id != 0 ? "${bowler.name} (BOWLER)" : "Bowler",
              data: data,
              path: bowler.id != 0 && bowler.image != 'null'
                  ? bowler.image ?? Constants.dummyImage
                  : "lib/assets/images/bowler.png",
              networkUrl: "",
              isStriker: false,
              isBowler: true,
              isNonStriker: false,
              player: bowler,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Custombutton(
                  onTap: () {
                    context.pop();
                  },
                  title: "Back",
                  width: 100,
                ),
                Custombutton(
                  onTap: () async {
                    if (bowler.id == 0) {
                      Toaster.onError(message: "Make sure you select a Bowler");
                      return;
                    }
                    final SelectBowlerReponse response = await ref
                        .watch(startMatchControllerProvider.notifier)
                        .selectBowler(
                          bowler: bowler,
                          order: 0,
                          inningsId: data.firstInnings?.isCompleted ?? false
                              ? data.inningsB ?? 0
                              : data.inningsA ?? 0,
                        );
                    ref.read(currentBowlerProvider.notifier).state =
                        response.bowler;
                    ref.read(currentOverProvider.notifier).state =
                        response.over;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ScoringPage(
                          data: data,
                        ),
                      ),
                    );
                  },
                  color: Colors.green,
                  title: "Next",
                  width: 100,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
