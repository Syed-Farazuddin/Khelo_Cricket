import 'package:crick_hub/feature/startTournament/domain/tournament_models.dart';

abstract class TournamentRepo {
  Future<bool> registerTournament(RegisterTournamentRequest request);
}
