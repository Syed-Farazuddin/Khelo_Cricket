abstract class MatchRepo {
  Future<void> fetchMatchOverview({required int matchId});

  Future<List<dynamic>> fetchMatchDetailItems();
}
