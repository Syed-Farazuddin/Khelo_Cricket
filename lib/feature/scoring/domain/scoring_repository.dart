import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';

abstract class ScoringRepository {
  Future<void> fetchInningsData({
    required int inningsId,
  });

  Future<void> updateScore({
    required Updatescoring scoring,
    required int inningsId,
  });

  Future<void> updateBatsman({
    required int currentBatsmanid,
    required Players batsman,
    required int inningsId,
  });

  Future<InningsModel> endInnings({
    required int inningsId,
  });

  Future<void> undoScore();

  Future<void> selectStrikers();

  Future<void> selectBowler();

  Future<void> fetchMatchData();
}
