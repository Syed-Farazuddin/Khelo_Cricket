import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkProvider = Provider((ref) => Network());

class Network {
  static String sendOtp() => 'auth/sendOtp';
  static String verifyOtp() => 'auth/verifyotp';
  static String profile() => 'profile';
  static String fetchTeams() => 'team/get_your_teams';
  static String getPlayerProfile({required final String userId}) =>
      'user/$userId/profile';
}
