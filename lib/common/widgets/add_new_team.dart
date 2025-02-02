import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class AddNewTeam extends StatefulWidget {
  const AddNewTeam({
    super.key,
    required this.addTeam,
    required this.controller,
  });
  final Function() addTeam;
  final TextEditingController controller;
  @override
  State<AddNewTeam> createState() => _AddNewTeamState();
}

class _AddNewTeamState extends State<AddNewTeam> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            "Add new Team",
            style: CustomTextStyles.large.copyWith(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: CustomInputField(
                  controller: widget.controller,
                  label: 'Enter team name',
                  textAllowed: true,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Custombutton(
                onTap: widget.addTeam,
                title: "Add",
                showIcon: true,
                icon: Icons.add_circle,
                width: 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
