import 'package:crick_hub/feature/scoring/data/scoring_repo.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/data/repository/start_match_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_match_controller.g.dart';

@riverpod
class StartMatchController extends _$StartMatchController {
  @override
  void build() {
    return;
  }

  Future<List<Team>> fetchYourTeams() async {
    final teams = await ref.read(startMatchRepositoryProvider).fetchYourTeams();
    return teams;
  }

  Future<void> addNewTeam({
    required String name,
  }) async {
    await ref.read(startMatchRepositoryProvider).addNewTeam(name: name);
  }

  Future<AddTeamResponse> addNewPlayer({
    required String number,
    required int teamId,
  }) async {
    return await ref.read(startMatchRepositoryProvider).addNewPlayer(
          teamId: teamId,
          mobile: number,
        );
  }

  Future<AddTeamResponse> createNewPlayerAndAddInTeam({
    required String mobile,
    required int teamId,
    required String name,
  }) async {
    return await ref
        .read(startMatchRepositoryProvider)
        .createNewPlayerAndAddInTeam(
          teamId: teamId,
          mobile: mobile,
          name: name,
        );
  }

  Future<MatchData> startYourMatch({
    required StartMatchRequestBody request,
  }) async {
    return await ref
        .read(startMatchRepositoryProvider)
        .startYourMatch(request: request);
  }

  Future<MatchData> startNewInnings({
    required StartNewInnings request,
  }) async {
    return await ref
        .read(startMatchRepositoryProvider)
        .startNewInnings(request: request);
  }

  Future<void> updateBatsman({
    required int currentBatsmanid,
    required Players batsman,
    required int inningsId,
  }) async {
    return await ref.read(scoringRepositoryProvider).updateBatsman(
          batsman: batsman,
          currentBatsmanid: currentBatsmanid,
          inningsId: inningsId,
        );
  }

  Future<void> selectBatsmans({
    required Players striker,
    required Players nonStriker,
    required int inningsId,
  }) async {
    return await ref.read(startMatchRepositoryProvider).selectBatsmans(
          striker: striker,
          nonStriker: nonStriker,
          inningsId: inningsId,
        );
  }

  Future<SelectBowlerReponse> selectBowler({
    required Players bowler,
    required int inningsId,
    required int order,
  }) async {
    return await ref.read(startMatchRepositoryProvider).selectBowler(
          bowler: bowler,
          inningsId: inningsId,
          order: order,
        );
  }
}
