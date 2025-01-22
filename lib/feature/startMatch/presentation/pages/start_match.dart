import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/common/widgets/squads.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_batsman.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/team_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StartOrScheduleMatch extends ConsumerStatefulWidget {
  const StartOrScheduleMatch({super.key, required this.startMatch});
  final bool startMatch;

  @override
  ConsumerState<StartOrScheduleMatch> createState() =>
      _StartOrScheduleMatchState();
}

class _StartOrScheduleMatchState extends ConsumerState<StartOrScheduleMatch> {
  int tossWonTeam = 0;
  bool choseToBat = true;
  late MatchData data;
  late final TextEditingController state;
  late final TextEditingController overs;
  late final TextEditingController ground;
  late final TextEditingController overLimit;
  late final TextEditingController location;

  get itemCount => null;

  @override
  void initState() {
    super.initState();
    state = TextEditingController();
    overLimit = TextEditingController();
    ground = TextEditingController();
    overs = TextEditingController();
    location = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    state.dispose();
    overLimit.dispose();
    ground.dispose();
    overs.dispose();
    location.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamA = ref.watch(selectedTeamA);
    final teamB = ref.watch(selectedTeamB);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(
            12,
          ),
          child: Column(
            children: [
              Squads(
                teamA: teamA.name,
                teamAPlayers: teamA.players,
                teamB: teamB.name,
                teamBPlayers: teamB.players,
              ),
              const SizedBox(
                height: 30,
              ),
              if (widget.startMatch)
                tossWonDetails(
                  teamA: teamA,
                  teamB: teamB,
                ),
              CustomInputField(
                controller: state,
                label: "Enter State",
                textAllowed: true,
              ),
              CustomInputField(
                controller: ground,
                label: "Enter Ground",
                textAllowed: true,
              ),
              CustomInputField(
                controller: location,
                label: "Enter Location",
                textAllowed: true,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
                      controller: overs,
                      onchanged: (value) {
                        if (value.isNotEmpty) {}
                      },
                      label: "Overs",
                    ),
                  ),
                  Expanded(
                    child: CustomInputField(
                      controller: overLimit,
                      onchanged: (value) => debugPrint(value),
                      label: "Over Limit",
                    ),
                  ),
                ],
              ),
              startOrScheduleButton(
                isStartMatch: widget.startMatch,
                teamA: teamA,
                teamB: teamB,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tossWonDetails({required Team teamA, required Team teamB}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Show toss info
        Text(
          "Toss Won By",
          style: GoogleFonts.golosText(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            TeamDisplay(
              label: teamA.name,
              teamNo: 1,
              backgroundColor:
                  tossWonTeam == teamA.teamId ? Colors.blue : Colors.white,
              onTap: () {
                setState(() {
                  tossWonTeam = teamA.teamId;
                });
              },
              teams: const [],
            ),
            const SizedBox(
              width: 15,
            ),
            TeamDisplay(
              label: teamB.name,
              teamNo: 2,
              backgroundColor:
                  tossWonTeam == teamB.teamId ? Colors.blue : Colors.white,
              onTap: () {
                setState(() {
                  tossWonTeam = teamB.teamId;
                });
              },
              teams: const [],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Choose to ",
          style: GoogleFonts.golosText(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            chooseTo(
                label: "Bat",
                isActive: choseToBat,
                onTap: () {
                  setState(() {
                    choseToBat = true;
                  });
                }),
            const SizedBox(
              width: 20,
            ),
            chooseTo(
                label: "Bowl",
                isActive: !choseToBat,
                onTap: () {
                  setState(() {
                    choseToBat = false;
                  });
                })
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget startOrScheduleButton({
    required bool isStartMatch,
    required Team teamA,
    required Team teamB,
  }) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Custombutton(
                  onTap: () async {
                    if (isStartMatch) {
                      await onStartMatch(teamA: teamA, teamB: teamB);
                    } else {
                      await onScheduleMatch();
                    }
                  },
                  title: isStartMatch ? "Start" : "Schedule",
                  width: 200,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget chooseTo({
    required String label,
    required bool isActive,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        width: 100,
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          label,
          style: GoogleFonts.golosText(
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> onStartMatch({required Team teamA, required Team teamB}) async {
    List<int> teamAPlayers = [];
    for (int i = 0; i < teamA.players.length; i++) {
      Players player = teamA.players[i];
      if (player.selected) {
        teamAPlayers.add(player.id);
      }
    }
    List<int> teamBPlayers = [];
    for (int i = 0; i < teamB.players.length; i++) {
      Players player = teamB.players[i];
      if (player.selected) {
        teamBPlayers.add(player.id);
      }
    }
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    StartMatchRequestBody request = StartMatchRequestBody(
      date: date,
      ballType: "Tennis",
      tossWonTeamId: tossWonTeam,
      chooseToBat: choseToBat,
      teams: [teamA.teamId, teamB.teamId],
      bowlingLimit: int.parse(overLimit.text),
      overs: int.parse(overs.text),
      ground: ground.text,
      state: state.text,
      teamAPlayers: teamAPlayers,
      teamBPlayers: teamBPlayers,
    );
    data = await ref
        .watch(startMatchControllerProvider.notifier)
        .startYourMatch(request: request);
    ref.read(currentMatchProvider.notifier).state = data;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectBatsman(),
      ),
    );
  }

  Future<void> onScheduleMatch() async {}
}
