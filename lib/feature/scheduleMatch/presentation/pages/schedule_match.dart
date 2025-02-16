import 'package:flutter/material.dart';

class ScheduleMatch extends StatefulWidget {
  const ScheduleMatch({super.key});

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
        children: [],
      ),
    );
  }
}
