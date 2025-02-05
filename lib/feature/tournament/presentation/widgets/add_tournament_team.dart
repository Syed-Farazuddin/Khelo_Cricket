import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/add_new_team.dart';
import 'package:crick_hub/common/widgets/search_team.dart';
import 'package:crick_hub/common/widgets/show_teams.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTeam extends ConsumerStatefulWidget {
  const AddTeam({
    super.key,
    required this.addTeam,
    required this.onSearch,
    required this.controller,
    required this.label,
    required this.teams,
    required this.selectTeam,
    required this.searchController,
  });

  final TextEditingController controller;
  final TextEditingController searchController;
  final Function() onSearch;
  final List<Team> teams;
  final Function() addTeam;
  final Function(int val) selectTeam;
  final String label;

  @override
  ConsumerState<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends ConsumerState<AddTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.label,
          style: CustomTextStyles.large,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SearchTeam(
                onSearch: widget.onSearch,
                controller: widget.searchController,
              ),
            ),
            if (widget.teams.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Search results",
                      style: CustomTextStyles.large.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ShowTeams(
                      teams: widget.teams,
                      selectTeam: widget.selectTeam,
                      selectedTeam: 0,
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AddNewTeam(
                addTeam: widget.addTeam,
                controller: widget.controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showTeams() {}
}
