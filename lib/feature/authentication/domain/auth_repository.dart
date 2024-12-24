import 'package:crick_hub/feature/authentication/domain/auth_models.dart';

abstract class AuthenticationRepository {
  Future<CustomResponse> sendOtp({required String mobile});

  Future<bool> verifyOtp({
    required String mobile,
    required String otp,
    required bool isNewPlayer,
  });

  Future<User> fetchuserDetails();

  Future<void> updateFirebaseToken();
}
