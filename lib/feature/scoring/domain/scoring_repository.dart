import 'package:crick_hub/feature/scoring/data/scoring_models.dart';

abstract class ScoringRepository {
  Future<void> fetchInningsData({
    required int inningsId,
  });

  Future<void> updateScore({
    required Updatescoring scoring,
    required int inningsId,
  });

  Future<void> undoScore();

  Future<void> batsmenOut();

  Future<void> selectStrikers();

  Future<void> selectBowler();

  Future<void> fetchMatchData();
}
