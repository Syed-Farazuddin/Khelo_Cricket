import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/authentication/domain/auth_models.dart';
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
  Future<CustomResponse> sendOtp({required String mobile}) async {
    CustomResponse result = CustomResponse(
      field: null,
      message: null,
      status: null,
    );
    try {
      final response = await baseService.post(
        Network.sendOtp(),
        body: {
          'mobile': mobile,
        },
      );
      result = CustomResponse.fromJson(
        json: response,
        field: response['newUser'],
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
  Future<bool> verifyOtp({
    required String mobile,
    required String otp,
    required bool isNewPlayer,
  }) async {
    final body = {
      'mobile': mobile,
      'otp': otp,
      'isNewPlayer': isNewPlayer,
    };
    bool result = false;
    try {
      final response = await baseService.post(Network.verifyOtp(), body: body);
      debugPrint(response.toString());
      Toaster.onSuccess(
        message: response['message'],
        gravity: ToastGravity.BOTTOM,
      );
      result = response['success'];
      if (result == true) {
        saveUserCredentials(response: response);
      }
    } catch (e) {
      debugPrint("Error in verify OTP API $e");
    }
    return result;
  }

  @override
  Future<void> updateFirebaseToken() async {}

  void saveUserCredentials({
    required Map<String, dynamic> response,
  }) {
    Storage storage = Storage();
    String token = response['token'];
    String userId = response['id'];
    String? name = response['name'];
    String? mobile = response['mobile'];

    storage.addItem(key: 'token', value: token);
    storage.addItem(key: 'id', value: userId);
    storage.addItem(key: 'name', value: name ?? "");
    storage.addItem(key: 'mobile', value: mobile ?? "");
  }

  @override
  Future<User> fetchuserDetails() {
    throw UnimplementedError();
  }
}
