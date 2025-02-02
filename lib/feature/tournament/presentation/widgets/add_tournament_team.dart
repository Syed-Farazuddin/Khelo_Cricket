import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/add_new_team.dart';
import 'package:crick_hub/common/widgets/search_team.dart';
import 'package:flutter/material.dart';

class AddTeam extends StatefulWidget {
  const AddTeam({
    super.key,
    required this.addTeam,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final Function() addTeam;
  final String label;

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  List teams = [];

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
                onSearch: () {},
              ),
            ),
            const SizedBox(
              height: 20,
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
}
