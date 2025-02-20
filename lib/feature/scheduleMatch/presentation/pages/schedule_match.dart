import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ScheduleMatch extends StatefulWidget {
  const ScheduleMatch({
    super.key,
    required this.tournamentId,
  });
  final int tournamentId;

  @override
  State<ScheduleMatch> createState() => _ScheduleMatchState();
}

class _ScheduleMatchState extends State<ScheduleMatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedule Match',
        ),
      ),
      body: Column(
        children: [
          Custombutton(onTap: () {}, title: "Select Teams", width: 100)
        ],
      ),
    );
  }
}
