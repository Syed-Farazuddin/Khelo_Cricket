import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/common/widgets/player_card.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTeamPlayer extends ConsumerStatefulWidget {
  const SelectTeamPlayer({
    super.key,
    required this.team,
    required this.teamNo,
    required this.refreshTeamsData,
  });
  final int teamNo;
  final Team team;
  final Future<void> Function() refreshTeamsData;

  @override
  ConsumerState<SelectTeamPlayer> createState() => _SelectTeamPlayerState();
}

class _SelectTeamPlayerState extends ConsumerState<SelectTeamPlayer> {
  int active = 0;
  bool showCreateNewPlayer = false;
  TextEditingController mobileController = TextEditingController();
  final List<String> fields = ["Using mobile Number", "Without Mobile"];

  @override
  Widget build(BuildContext context) {
    if (showCreateNewPlayer) {
      final TextEditingController nameController = TextEditingController();
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Enter Player's Name",
                style: GoogleFonts.golosText(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomInputField(
              textAllowed: true,
              maxlength: 40,
              controller: nameController,
              label: "",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Custombutton(
                      onTap: () {
                        setState(() {
                          showCreateNewPlayer = false;
                        });
                      },
                      title: "Close",
                      width: 0,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Custombutton(
                      onTap: () {
                        if (nameController.text.isEmpty) {
                          Toaster.onError(
                            message: "Please Enter a valid name",
                          );
                          return;
                        }
                        createNewUserAndAddInTeam(
                          teamId: widget.team.teamId,
                          name: nameController.text,
                          mobile: mobileController.text,
                        );
                      },
                      title: "Add",
                      width: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team :  ${widget.team.name}",
            style: GoogleFonts.golosText(
              color: Colors.white.withOpacity(0.9),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Add New Player",
            style: GoogleFonts.golosText(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonList(
            list: fields,
            onTap: (value) {
              setState(() {
                active = value;
              });
            },
            active: active,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                  controller: mobileController,
                  maxlength: 10,
                  label: "Add new player ${fields[active]}",
                ),
              ),
              Custombutton(
                onTap: () async {
                  await addNewPlayer(
                    teamId: widget.team.teamId,
                    mobile: mobileController.text,
                  );
                },
                width: 80.0,
                showIcon: true,
                title: "Add",
                icon: Icons.add,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Players Selected : ${widget.team.selectedPlayers.length}",
            style: GoogleFonts.golosText(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Previously added players",
            style: GoogleFonts.golosText(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.team.players.length,
            itemBuilder: (builder, index) {
              Players player = widget.team.players[index];
              return PlayerCard(
                showSelectPlayerIcon: true,
                player: player,
                onTap: () {
                  if (widget.team.selectedPlayers.contains(player.id)) {
                    setState(() {
                      widget.team.selectedPlayers.remove(player.id);
                      player.selected = false;
                    });
                  } else if (widget.team.selectedPlayers.length <= 11) {
                    setState(() {
                      widget.team.selectedPlayers.add(
                        player.id,
                      );
                      player.selected = true;
                    });
                  } else {
                    Toaster.onError(
                      message: "Can't select more than 12 players",
                    );
                  }
                },
                color: widget.team.selectedPlayers.contains(player.id)
                    ? Colors.blue
                    : Colors.white.withOpacity(
                        0.1,
                      ),
                borderColor: widget.team.selectedPlayers.contains(player.id)
                    ? Colors.blue
                    : Colors.white.withOpacity(
                        0.1,
                      ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Custombutton(
                    onTap: () {
                      context.goNamed('/startMatch');
                    },
                    title: "Cancel",
                    textColor: Colors.white,
                    color: Colors.red,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Custombutton(
                    onTap: () {
                      if (widget.teamNo == 1) {
                        ref.watch(selectedTeamA.notifier).state = widget.team;
                        // setState(() {});
                      } else {
                        ref.read(selectedTeamB.notifier).state = widget.team;
                        // setState(() {});
                      }
                      context.pop();
                      setState(() {});
                    },
                    textColor: Colors.white,
                    title: "Done",
                    color: Colors.green,
                    width: 100,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> addNewPlayer({
    required int teamId,
    required String mobile,
  }) async {
    final AddTeamResponse res = await ref
        .read(startMatchControllerProvider.notifier)
        .addNewPlayer(number: mobile, teamId: teamId);
    if (!res.playerExists) {
      setState(() {
        showCreateNewPlayer = true;
      });
      return;
    }
    setState(() {});
    widget.refreshTeamsData();
  }

  Future<void> createNewUserAndAddInTeam({
    required int teamId,
    required String name,
    required String mobile,
  }) async {
    final AddTeamResponse res = await ref
        .read(startMatchControllerProvider.notifier)
        .createNewPlayerAndAddInTeam(
          mobile: mobile,
          teamId: teamId,
          name: name,
        );
    if (res.success) {
      Toaster.onSuccess(
        message: res.message ?? "",
        gravity: ToastGravity.BOTTOM,
      );
      setState(() {
        showCreateNewPlayer = false;
      });
      mobileController.text = "";
      setState(() {});
      widget.refreshTeamsData();
    }
  }
}
