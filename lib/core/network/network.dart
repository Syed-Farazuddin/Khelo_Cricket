import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkProvider = Provider((ref) => Network());

class Network {
  // Auth LINKS
  static String sendOtp() => 'auth/sendOtp';
  static String verifyOtp() => 'auth/verifyotp';
  static String createPlayerAndAddInTeam() =>
      'auth/create_player_and_add_in_team';

  // Profile Links

  static String profile() => 'profile';
  static String updateProfile({required int id}) => '/profile/$id/update';

  // Team Data Links

  static String fetchTeams() => 'team/get_your_teams';
  static String searchTeams({required String name}) => 'team/$name/search';
  static String fetchTeamDetails({required int id}) => 'team/$id/details';
  static String createNewTeam() => 'team/create_team';
  static String addNewPlayer({
    required int teamId,
  }) =>
      'team/$teamId/add_player';

  // Matches LINKS

  static String startYourMatch() => "/matches/start_match";
  static String scheduleYourMatch() => "/matches/schedule_match";

  static String startNewInnings() => '/matches/start_new_innings';
  static String getYourMatches() => "/matches/your_matches";
  static String updateBatmans({required int inningsId}) =>
      '/matches/$inningsId/scoring/update_batsman';
  static String getPlaying11({required int inningsId}) =>
      '/matches/$inningsId/get_team_players';
  static String getPlayerProfile({required final String userId}) =>
      'user/$userId/profile';
  static String updateScore({required int inningsId}) =>
      '/matches/$inningsId/scoring';
  static String selectBatmans({required int inningsId}) =>
      '/matches/$inningsId/scoring/select_batsman';
  static String selectBowler({required int inningsId}) =>
      '/matches/$inningsId/scoring/select_bowler';
  static String getInningsData({required int inningsid}) =>
      '/matches/innings/$inningsid';
  static String endMatch({required int matchId}) =>
      '/matches/$matchId/end_match';
  static String getMatchOverview({required int matchId}) =>
      '/matches/$matchId/match_overview';
  static String getMatchDetailItems() => '/matches/items';
  static String isWicket() => '';

  // Tournament URLS

  static String registerTournament() => "/tournament/register";
  static String fetchTournamentTeams({required int id}) =>
      'tournament/$id/teams';

  static String getYourTournaments() => "/tournament";
  static String addNewTeam({required int id}) => "tournament/$id/add_team";
  static String getTournamentItems() => "tournament/items";
  static String getTournamentInfo({required int id}) => "tournament/$id/info";
}
