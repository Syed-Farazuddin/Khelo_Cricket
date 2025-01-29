import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_controller.dart';
import 'package:crick_hub/feature/startMatch/presentation/providers/start_match_providers.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/team_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTeams extends ConsumerStatefulWidget {
  const SelectTeams({
    super.key,
  });
  @override
  ConsumerState<SelectTeams> createState() => _SelectTeamsState();
}

class _SelectTeamsState extends ConsumerState<SelectTeams> {
  bool viewSquads = true;
  bool loading = false;
  late List<Team> yourTeams = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() {
      removeSelectedTeamAData();
      removeSelectedTeamBData();
      fetchYourTeams();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Team teamA = ref.watch(selectedTeamA);
    final Team teamB = ref.watch(selectedTeamB);
    return Scaffold(
      appBar: AppBar(),
      body: loading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Select Teams",
                      style: CustomTextStyles.largeText,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TeamDisplay(
                          label: teamA.name.isEmpty ? "Team A" : teamA.name,
                          teamNo: 1,
                          onTap: () {
                            context.pushNamed(
                              "/selectTeam",
                              extra: StartMatchExtras(
                                teamName:
                                    teamA.name.isEmpty ? "Team A" : teamA.name,
                                teamNo: 1,
                                refreshData: fetchYourTeams,
                                yourTeams: yourTeams,
                              ),
                            );
                          },
                          teams: yourTeams,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TeamDisplay(
                          teamNo: 1,
                          teams: yourTeams,
                          label: teamB.name.isEmpty ? "Team B" : teamB.name,
                          onTap: () {
                            context.pushNamed(
                              "/selectTeam",
                              extra: StartMatchExtras(
                                teamName:
                                    teamB.name.isEmpty ? "Team B" : teamB.name,
                                teamNo: 2,
                                refreshData: fetchYourTeams,
                                yourTeams: yourTeams,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (teamA.players.isNotEmpty || teamB.players.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            viewSquads = !viewSquads;
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: viewSquads,
                              onChanged: (value) {
                                setState(() {
                                  viewSquads = value ?? false;
                                });
                              },
                            ),
                            Text(
                              "Squads",
                              style: GoogleFonts.golosText(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (viewSquads)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showSquads(
                            team: teamA,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          showSquads(
                            team: teamB,
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (teamB.selectedPlayers.length > 5 &&
                        teamA.selectedPlayers.length > 5)
                      Row(
                        children: [
                          Expanded(
                            child: Custombutton(
                              onTap: () {
                                context.pushNamed("/startMatch");
                              },
                              title: "Schedule Match",
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: Custombutton(
                              onTap: () {
                                context.pushNamed("/startMatch");
                              },
                              title: "Start Match",
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> removeSelectedTeamAData() async {
    ref.read(selectedTeamA.notifier).state = Team(
      name: '',
      teamId: 0,
      players: [],
      selectedPlayers: [],
    );
  }

  Future<void> removeSelectedTeamBData() async {
    ref.read(selectedTeamB.notifier).state = Team(
      name: '',
      teamId: 0,
      players: [],
      selectedPlayers: [],
    );
  }

  Future<void> fetchYourTeams() async {
    loading = true;
    final res =
        await ref.read(startMatchControllerProvider.notifier).fetchYourTeams();
    setState(() {
      yourTeams = res;
    });
    ref.watch(teamDataProvider.notifier).state = res;
    loading = false;
  }

  Widget showSquads({required Team team}) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, idx) =>
            team.selectedPlayers.contains(team.players[idx].id)
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox.shrink(),
        itemBuilder: (context, idx) {
          return team.selectedPlayers.contains(team.players[idx].id)
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.withValues(
                      alpha: 0.14,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.network(
                            team.players[idx].image != 'null'
                                ? team.players[idx].image.toString()
                                : Constants.dummyImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        team.players[idx].name ?? "",
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink();
        },
        itemCount: team.players.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
