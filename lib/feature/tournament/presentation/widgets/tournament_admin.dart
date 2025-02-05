import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/tournament/data/tournament_repository.dart';
import 'package:crick_hub/feature/tournament/presentation/widgets/add_tournament_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentAdmin extends ConsumerStatefulWidget {
  const TournamentAdmin({
    super.key,
    required this.tournamentId,
  });
  final int tournamentId;

  @override
  ConsumerState<TournamentAdmin> createState() => _TournamentAdminState();
}

class _TournamentAdminState extends ConsumerState<TournamentAdmin> {
  final TextEditingController team = TextEditingController();
  int teamid = 0;
  final TextEditingController searchController = TextEditingController();
  List<Team> teams = [];
  int selectedTeam = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            action(
              label: "Add new Team",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => AddTeam(
                      searchController: searchController,
                      selectTeam: (val) {
                        setState(() {
                          selectedTeam = val;
                        });
                      },
                      onSearch: () {
                        searchTeams(name: searchController.text);
                      },
                      label: "Add New Team",
                      teams: teams,
                      addTeam: () {
                        registerNewTeam(
                          id: widget.tournamentId,
                          name: team.text,
                        );
                      },
                      controller: team,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10,
            ),
            action(
              label: "Schedule a Match",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchTeams({
    required String name,
  }) async {
    if (name.isEmpty) {
      setState(() {
        teams = [];
      });
      return;
    }
    final response = await ref
        .read(tournamentRepositoryProvider)
        .searchForTeams(teamName: name);
    setState(() {
      teams = response; // Ensures a new reference
    });
  }

  Future<void> registerNewTeam({
    required String name,
    required int id,
  }) async {
    ref.read(tournamentRepositoryProvider).addNewTeam(
          teamName: name,
          tournamentId: id,
          teamId: 1,
        );
  }

  Widget action({
    required String label,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withValues(
            alpha: 0.3,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              label,
              style:
                  CustomTextStyles.large.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}
