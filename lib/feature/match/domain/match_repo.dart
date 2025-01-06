import 'package:crick_hub/feature/match/domain/match_models.dart';

abstract class MatchRepo {
  Future<MatchOverviewModel> fetchMatchOverview({required int matchId});

  Future<List<dynamic>> fetchMatchDetailItems();
}
