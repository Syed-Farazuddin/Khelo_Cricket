import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/scoring/data/scoring_repo.dart';
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

  Future<void> isWicket(IsWicketRequest request) async {
    await ref.read(scoringRepositoryProvider).isWicket(request);
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

  Future<void> selectBatsman() async {}

  Future<void> selectBowler() async {}
}
