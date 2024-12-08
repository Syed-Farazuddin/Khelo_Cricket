abstract class ScoringRepository {
  Future<void> fetchInningsData();

  Future<void> updateScore();

  Future<void> undoScore();

  Future<void> batsmenOut();

  Future<void> selectStrikers();

  Future<void> selectBowler();

  Future<void> fetchMatchData();
}
