import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';

abstract class HomeRepo {
  Future<List<MatchData>> getYourMatches();
  Future<List<TournamentData>> getYourTournaments();
}
