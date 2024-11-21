import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/domain/repository/start_match_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final startMatchRepositoryProvider = Provider<StartMatchRepo>((ref) {
  BaseService baseService = ref.watch(baseServiceProvider);
  final storage = ref.watch(storageProvider);

  return StartMatchRepo(baseService: baseService, storage: storage);
});

class StartMatchRepo extends StartMatchRepository {
  StartMatchRepo({
    required this.baseService,
    required this.storage,
  });
  final BaseService baseService;
  final Storage storage;
  @override
  Future<List<Team>> fetchYourTeams() async {
    try {
      final response = await baseService.get(
        Network.fetchTeams(),
        options: Options(
          headers: {
            "Authorization": await storage.read(
              key: 'token',
            ),
          },
        ),
      ) as List<dynamic>;
      debugPrint(response.toString());
      final teams = response
          .map(
            (json) => Team.fromJson(json),
          )
          .toList();
      debugPrint(teams.toString());
      return teams;
    } catch (e) {
      debugPrint("Error while fetching your teams");
    }
    return [];
  }
}
