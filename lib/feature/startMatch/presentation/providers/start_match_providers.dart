import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teamDataProvider = StateProvider<List<Team>>((ref) {
  return [];
});

final selectedTeamA = StateProvider<Team>((ref) {
  return Team(
    name: '',
    teamId: 0,
    players: [],
    selectedPlayers: [],
  );
});

final selectedTeamB = StateProvider<Team>((ref) {
  return Team(
    name: '',
    teamId: 0,
    players: [],
    selectedPlayers: [],
  );
});
