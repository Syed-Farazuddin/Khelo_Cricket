import 'package:crick_hub/common/models/team_details.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';

abstract class TournamentRepo {
  Future<TournamentData> registerTournament(RegisterTournamentRequest request);

  Future<List> getTournamentItems();

  Future<bool> addNewTeam({
    required String teamName,
    required int tournamentId,
    required int teamId,
  });

  Future<TeamDetails> fetchTeamDetails({
    required int id,
  });

  Future<dynamic> getTournamentInfo({
    required int id,
  });

  Future<List<Team>> searchForTeams({
    required String teamName,
  });
}
