import 'package:crick_hub/feature/scoring/domain/scoring_repository.dart';

class ScoringRepo extends ScoringRepository {
  @override
  Future<void> fetchInningsData() async {}

  Future<void> fetchMatchData() async {}

  @override
  Future<void> undoScore() async {}

  @override
  Future<void> updateScore() async {}

  @override
  Future<void> batsmenOut() async {
    // TODO: implement batsmenOut
  }

  @override
  Future<void> selectBowler() async {
    // TODO: implement selectBowler
  }

  @override
  Future<void> selectStrikers() async {
    // TODO: implement selectStrikers
  }
}
