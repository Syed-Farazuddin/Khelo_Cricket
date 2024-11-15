import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/authentication/domain/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final baseService = ref.watch(baseServiceProvider);
    final secureStorage = ref.watch(storageProvider);
    return AuthRepository(
      baseService: baseService,
      storage: secureStorage,
    );
  },
);

class AuthRepository extends AuthenticationRepository {
  AuthRepository({
    required this.baseService,
    required this.storage,
  });
  final BaseService baseService;
  final Storage storage;

  @override
  Future<bool> sendOtp({required String mobile}) async {
    bool result = false;
    try {
      final response = await baseService.post(
        Network.sendOtp(),
        body: {
          'mobile': mobile,
        },
      );
      // final res = jsonDecode(response.toString());
      debugPrint(response.toString());
      Toaster.onSuccess(
        message: response['message'],
        gravity: ToastGravity.BOTTOM,
      );
      result = response['success'];
    } catch (e) {
      debugPrint("Error in verify OTP API $e");
    }
    return result;
  }

  @override
  Future<bool> verifyOtp() async {
    bool result = false;
    try {} catch (e) {
      debugPrint("Error in verify OTP API $e");
    }
    return result;
  }

  @override
  Future<void> updateFirebaseToken() async {}
}
