import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';

abstract class StartMatchRepository {
  Future<List<Team>> fetchYourTeams();
}
