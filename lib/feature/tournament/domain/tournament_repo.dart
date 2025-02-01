import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';

abstract class TournamentRepo {
  Future<bool> registerTournament(RegisterTournamentRequest request);
}
