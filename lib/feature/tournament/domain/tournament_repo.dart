import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';

abstract class TournamentRepo {
  Future<TournamentData> registerTournament(RegisterTournamentRequest request);

  Future<List> getTournamentItems();

  Future<bool> addNewTeam({
    required String teamName,
    required int tournamentId,
  });
}
