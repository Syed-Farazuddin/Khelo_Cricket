import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/providers/scoring_provider.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/scoring/presentation/pages/scoring.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/select_players_providers.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/show_roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectBowler extends ConsumerStatefulWidget {
  const SelectBowler({
    super.key,
    required this.data,
  });
  final MatchData data;
  @override
  ConsumerState<SelectBowler> createState() => _SelectBowlerState();
}

class _SelectBowlerState extends ConsumerState<SelectBowler> {
  late final MatchData data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final bowlerProvider = ref.watch(bowler);
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
                ref.read(bowler.notifier).state = player;
                context.pop();
              },
              role: bowlerProvider.id != 0
                  ? "${bowlerProvider.name} (BOWLER)"
                  : "Bowler",
              data: data,
              path: bowlerProvider.id != 0
                  ? bowlerProvider.image ?? Constants.dummyImage
                  : "lib/assets/images/bowler.png",
              networkUrl: "",
              isStriker: false,
              isBowler: true,
              isNonStriker: false,
              player: bowlerProvider,
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
                    if (bowlerProvider.id == 0) {
                      Toaster.onError(message: "Make sure you select a Bowler");
                      return;
                    }
                    final SelectBowlerReponse response = await ref
                        .watch(startMatchControllerProvider.notifier)
                        .selectBowler(
                          bowler: bowlerProvider,
                          order: 0,
                          inningsId: data.inningsA ?? 0,
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
