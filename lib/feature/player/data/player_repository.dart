import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/player/domain/player_models.dart';
import 'package:crick_hub/feature/player/domain/player_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerRepositoryProvider = Provider((ref) {
  final baseService = ref.read(baseServiceProvider);
  final storage = ref.read(storageProvider);
  return PlayerRepository(baseService: baseService, storage: storage);
});

class PlayerRepository extends PlayerRepo {
  final BaseService baseService;
  final Storage storage;
  PlayerRepository({
    required this.baseService,
    required this.storage,
  });

  @override
  Future<void> saveUserDetails({
    required UserDetails details,
  }) async {
    try {
      final id = await storage.read(
        key: 'userId',
      );
      final response = await baseService.post(
          Network.updateProfile(
            id: int.parse(id ?? '0'),
          ),
          body: {
            'name': details.name,
            'mobile': details.dob,
            'dob': details.dob,
            'age': details.age,
            'imageUrl': details.imageUrl,
          });
      debugPrint(response.data);
    } catch (e) {
      debugPrint("Error while Updating user details");
    }
  }
}
