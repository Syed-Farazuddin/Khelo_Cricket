import 'package:crick_hub/common/widgets/add_new_team.dart';
import 'package:flutter/material.dart';

class AddTeam extends StatelessWidget {
  const AddTeam({
    super.key,
    required this.addTeam,
    required this.controller,
  });

  final TextEditingController controller;
  final Function() addTeam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddNewTeam(
        addTeam: addTeam,
        controller: controller,
      ),
    );
  }
}
