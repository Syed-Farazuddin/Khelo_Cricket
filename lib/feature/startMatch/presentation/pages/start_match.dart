import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/common/widgets/player_card.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_batsman.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/team_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

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
              squads(
                teamA: teamA,
                teamB: teamB,
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

  Widget startOrScheduleButton(
      {required bool isStartMatch, required Team teamA, required Team teamB}) {
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

  Widget squads({required Team teamA, required Team teamB}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: showSquads(
            teamA,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: showSquads(
            teamB,
          ),
        ),
      ],
    );
  }

  Widget showSquads(Team team) {
    List<Players> players = team.players;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          team.name.toString(),
          style: GoogleFonts.golosText(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (builder, index) {
            return players[index].selected
                ? Container(
                    padding: const EdgeInsets.all(
                      12,
                    ),
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              players[index].name.toString(),
                              style: GoogleFonts.golosText(
                                fontSize: 16,
                              ),
                            ),
                            if (players[index].isCaptain) const Text("(C)")
                          ],
                        ),
                        const Icon(
                          Icons.arrow_right,
                          size: 28,
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
          separatorBuilder: (builder, index) => const SizedBox(
            height: 10,
          ),
          itemCount: players.length,
        ),
      ],
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

  Widget selectPlayer({
    required MatchData data,
    required bool selectBatman,
    required Players player,
  }) {
    final Team teamA = ref.read(selectedTeamA);
    final Team teamB = ref.read(selectedTeamB);
    final Team team;
    if (data.tossWonTeamId == teamA.teamId) {
      if (selectBatman && data.chooseToBat!) {
        team = teamA;
      } else {
        team = teamB;
      }
    } else {
      if (selectBatman && data.chooseToBat!) {
        team = teamB;
      } else {
        team = teamA;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: selectBatman
            ? const Text("Select Batsman")
            : const Text("Select Bowler"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: ListView.separated(
          itemBuilder: (builder, index) {
            final Players currPlayer = team.players[index];
            if (team.selectedPlayers.contains(currPlayer.id)) {
              return PlayerCard(
                player: currPlayer,
                showSelectPlayerIcon: true,
                onTap: () {
                  setState(() {
                    player = currPlayer;
                  });
                  context.pop();
                },
                color: const Color.fromARGB(54, 255, 255, 255),
                borderColor: Colors.white.withValues(alpha: 0.2),
              );
            }
            return const SizedBox.shrink();
          },
          separatorBuilder: (builder, index) =>
              team.selectedPlayers.contains(team.players[index].id)
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox.shrink(),
          itemCount: team.players.length,
        ),
      ),
    );
  }

  Future<void> onScheduleMatch() async {}
}
