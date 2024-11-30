import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartOrScheduleMatch extends ConsumerStatefulWidget {
  const StartOrScheduleMatch({super.key, required this.startMatch});
  final bool startMatch;

  @override
  ConsumerState<StartOrScheduleMatch> createState() =>
      _StartOrScheduleMatchState();
}

class _StartOrScheduleMatchState extends ConsumerState<StartOrScheduleMatch> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
