abstract class AuthenticationRepository {
  Future<bool> sendOtp({required String mobile});

  Future<bool> verifyOtp();

  Future<void> updateFirebaseToken();
}
