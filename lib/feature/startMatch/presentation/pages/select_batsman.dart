import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_bowler.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/select_players_providers.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/show_roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectBatsman extends ConsumerStatefulWidget {
  const SelectBatsman({
    super.key,
    required this.data,
  });
  final MatchData data;
  @override
  ConsumerState<SelectBatsman> createState() => _SelectBatsmanState();
}

class _SelectBatsmanState extends ConsumerState<SelectBatsman> {
  late final MatchData data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final strikerProvider = ref.watch(striker);
    final nonStrikerProvider = ref.watch(nonStriker);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Batsman",
          style: GoogleFonts.golosText(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShowRoles(
                  role: strikerProvider.id != 0
                      ? strikerProvider.name ?? ""
                      : "Striker",
                  path:
                      strikerProvider.id != 0 && strikerProvider.image != 'null'
                          ? strikerProvider.image ?? Constants.dummyImage
                          : "lib/assets/images/striker.png",
                  networkUrl: Network.selectBatmans(
                    inningsId: data.inningsA ?? 0,
                  ),
                  isStriker: true,
                  isBowler: false,
                  isNonStriker: false,
                  player: strikerProvider,
                  data: data,
                  ontap: (player) {
                    ref.read(striker.notifier).state = player;
                    context.pop();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                ShowRoles(
                  isStriker: false,
                  isBowler: false,
                  data: data,
                  isNonStriker: true,
                  role: nonStrikerProvider.id != 0
                      ? nonStrikerProvider.name ?? ""
                      : "Striker",
                  path: nonStrikerProvider.id != 0 &&
                          nonStrikerProvider.image != 'null'
                      ? nonStrikerProvider.image ?? Constants.dummyImage
                      : "lib/assets/images/non_striker.png",
                  networkUrl: Network.selectBatmans(
                    inningsId: data.inningsA ?? 0,
                  ),
                  player: nonStrikerProvider,
                  ontap: (player) {
                    ref.read(nonStriker.notifier).state = player;
                    context.pop();
                  },
                ),
              ],
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
                    if (strikerProvider.id == 0) {
                      Toaster.onError(
                        message: "Make sure you select Striker",
                      );
                      return;
                    }

                    if (nonStrikerProvider.id == 0) {
                      Toaster.onError(
                        message: "Make sure you select Non Striker",
                      );
                      return;
                    }
                    await ref
                        .watch(startMatchControllerProvider.notifier)
                        .selectBatsmans(
                          striker: strikerProvider,
                          nonStriker: nonStrikerProvider,
                          inningsId: data.inningsA ?? 0,
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => SelectBowler(data: data),
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
