import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/profile/data/profile_models.dart';
import 'package:crick_hub/feature/profile/domain/profile_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final baseService = ref.watch(baseServiceProvider);
  final storage = ref.watch(storageProvider);
  return ProfileRepository(
    baseService: baseService,
    storage: storage,
  );
});

class ProfileRepository extends ProfileRepo {
  ProfileRepository({
    required this.baseService,
    required this.storage,
  });
  final BaseService baseService;
  final Storage storage;

  @override
  Future<ProfileInfo> getProfileInfo() async {
    try {
      final response = await baseService.get(
        Network.profile(),
        options: Options(
          headers: {
            "Authorization": await storage.read(
              key: 'token',
            ),
          },
        ),
      );
      ProfileInfo profileInfo = ProfileInfo.fromJson(response);
      return profileInfo;
    } catch (e) {
      debugPrint("This error is caused in profile repository $e");
      Toaster.onError(message: 'Something went wrong');
    }
    return ProfileInfo(
      stats: PlayerStats(
        stats: [[], [], []],
      ),
    );
  }
}
