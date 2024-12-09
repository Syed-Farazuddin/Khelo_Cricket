import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';

abstract class StartMatchRepository {
  Future<List<Team>> fetchYourTeams();

  Future<bool> addNewTeam({required String name});

  Future<AddTeamResponse> addNewPlayer({
    required int teamId,
    required String mobile,
  });

  Future<AddTeamResponse> createNewPlayerAndAddInTeam({
    required int teamId,
    required String mobile,
    required String name,
  });

  Future<void> startYourMatch({
    required StartMatchRequestBody request,
  });

  Future<void> selectBatsmans({
    required Players striker,
    required Players nonStriker,
    required int inningsId,
  });
}
