class Network {
  static String sendOtp() => 'auth/sendOtp';
  static String verifyOtp() => 'auth/verifyOtp';
  static String profile() => 'user/profile';
  static String getPlayerProfile({required final String userId}) =>
      'user/$userId/profile';
}