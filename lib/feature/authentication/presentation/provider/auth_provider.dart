import 'package:crick_hub/feature/authentication/data/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {
  @override
  void build() {
    return;
  }

  Future<bool> sendOtp({required String mobile}) async {
    return await ref.read(authRepositoryProvider).sendOtp(mobile: mobile);
  }

  Future<bool> verifyOtp({required String mobile, required String otp}) async {
    return await ref
        .read(authRepositoryProvider)
        .verifyOtp(mobile: mobile, otp: otp);
  }
}
