import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_bowler.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/show_roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectBatsman extends ConsumerStatefulWidget {
  const SelectBatsman({
    super.key,
  });
  @override
  ConsumerState<SelectBatsman> createState() => _SelectBatsmanState();
}

class _SelectBatsmanState extends ConsumerState<SelectBatsman> {
  // late final MatchData data;
  @override
  void initState() {
    super.initState();
    // data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final MatchData data = ref.watch(currentMatchProvider);
    Players striker = Players(name: 'name', id: 0);
    Players nonStriker = Players(name: 'name', id: 0);
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
                  role: striker.id != 0 ? striker.name ?? "" : "Striker",
                  path: striker.id != 0 && striker.image != 'null'
                      ? striker.image ?? Constants.dummyImage
                      : "lib/assets/images/striker.png",
                  networkUrl: Network.selectBatmans(
                    inningsId: data.firstInnings?.isCompleted ?? false
                        ? data.inningsB ?? 0
                        : data.inningsA ?? 0,
                  ),
                  isStriker: true,
                  isBowler: false,
                  isNonStriker: false,
                  player: striker,
                  data: data,
                  ontap: (player) {
                    striker = player;
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
                  role: nonStriker.id != 0 ? nonStriker.name ?? "" : "Striker",
                  path: nonStriker.id != 0 && nonStriker.image != 'null'
                      ? nonStriker.image ?? Constants.dummyImage
                      : "lib/assets/images/non_striker.png",
                  networkUrl: Network.selectBatmans(
                    inningsId: data.firstInnings?.isCompleted ?? false
                        ? data.inningsB ?? 0
                        : data.inningsA ?? 0,
                  ),
                  player: nonStriker,
                  ontap: (player) {
                    nonStriker = player;
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
                    if (striker.id == 0) {
                      Toaster.onError(
                        message: "Make sure you select Striker",
                      );
                      return;
                    }

                    if (striker.id == 0) {
                      Toaster.onError(
                        message: "Make sure you select Non Striker",
                      );
                      return;
                    }
                    await ref
                        .watch(startMatchControllerProvider.notifier)
                        .selectBatsmans(
                          striker: striker,
                          nonStriker: nonStriker,
                          inningsId: data.firstInnings?.isCompleted ?? false
                              ? data.inningsB ?? 0
                              : data.inningsA ?? 0,
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const SelectBowler(),
                      ),
                    );
                  },
                  color: Colors.green,
                  title: "Next",
                  width: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
