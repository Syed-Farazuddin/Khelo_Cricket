import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkProvider = Provider((ref) => Network());

class Network {
  static String sendOtp() => 'auth/sendOtp';
  static String verifyOtp() => 'auth/verifyotp';
  static String profile() => 'profile';
  static String updateProfile({required int id}) => '/profile/$id/update';
  static String fetchTeams() => 'team/get_your_teams';
  static String createNewTeam() => 'team/create_team';
  static String addNewPlayer({required int teamId}) =>
      'team/$teamId/add_player';
  static String createPlayerAndAddInTeam() =>
      'auth/create_player_and_add_in_team';
  static String getPlayerProfile({required final String userId}) =>
      'user/$userId/profile';
  static String startYourMatch() => "/matches/start_match";
  static String startNewInnings() => '/matches/start_new_innings';
  static String getYourMatches() => "/matches/your_matches";
  static String updateScore({required int inningsId}) =>
      '/matches/$inningsId/scoring';
  static String selectBatmans({required int inningsId}) =>
      '/matches/$inningsId/scoring/select_batsman';
  static String selectBowler({required int inningsId}) =>
      '/matches/$inningsId/scoring/select_bowler';
  static String getInningsData({required int inningsid}) =>
      '/matches/innings/$inningsid';
  static String getMatchOverview({required int matchId}) =>
      '/matches/$matchId/match_overview';
  static String getMatchDetailItems() => '/matches/items';
}
