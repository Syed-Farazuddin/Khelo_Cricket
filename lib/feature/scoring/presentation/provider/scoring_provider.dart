import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/scoring/data/scoring_repo.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scoring_provider.g.dart';

@riverpod
class ScoringProvider extends _$ScoringProvider {
  @override
  void build() {
    return;
  }

  Future<UpdateScoringResponse> updateScoring({
    required Updatescoring scoring,
    required int inningsId,
  }) async {
    return await ref
        .read(scoringRepositoryProvider)
        .updateScore(scoring: scoring, inningsId: inningsId);
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

  Future<InningsModel> getInningsData({required int inningsId}) async {
    return await ref
        .read(scoringRepositoryProvider)
        .fetchInningsData(inningsId: inningsId);
  }

  Future<InningsModel> endInnings({required int inningsId}) async {
    return await ref
        .read(scoringRepositoryProvider)
        .endInnings(inningsId: inningsId);
  }

  Future<bool> endMatch({
    required int matchId,
  }) async {
    return await ref.read(scoringRepositoryProvider).endMatch(
          matchId: matchId,
        );
  }

  Future<List<Players>> getPlayingTeam({
    required bool battingPlayers,
    required int inningsId,
  }) async {
    return await ref.read(scoringRepositoryProvider).getPlayingTeam(
          inningsId: inningsId,
          battingPlayers: battingPlayers,
        );
  }

  Future<void> selectBatsman() async {}

  Future<void> selectBowler() async {}
}
