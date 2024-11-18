abstract class AuthenticationRepository {
  Future<bool> sendOtp({required String mobile});

  Future<bool> verifyOtp({required String mobile, required String otp});

  Future<void> updateFirebaseToken();
}
