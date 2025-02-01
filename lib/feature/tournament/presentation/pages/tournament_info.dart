import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentInfo extends ConsumerStatefulWidget {
  const TournamentInfo({super.key});

  @override
  ConsumerState<TournamentInfo> createState() => _TournamentInfoState();
}

class _TournamentInfoState extends ConsumerState<TournamentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'data',
          ),
          Image.network(
            'src',
          ),
        ],
      ),
    );
  }
}
