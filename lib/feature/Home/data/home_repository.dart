import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/Home/domain/home_repo.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider((ref) {
  final BaseService baseService = ref.read(baseServiceProvider);
  final Storage storage = ref.read(storageProvider);
  return HomeRepository(
    baseService: baseService,
    storage: storage,
  );
});

class HomeRepository extends HomeRepo {
  final BaseService baseService;
  final Storage storage;

  HomeRepository({
    required this.baseService,
    required this.storage,
  });

  @override
  Future<List<MatchData>> getYourMatches() async {
    List<MatchData> result = [];
    try {
      final List response = await baseService.post(
        Network.getYourMatches(),
        options: Options(
          headers: {
            "Authorization": await storage.read(
              key: 'token',
            ),
          },
        ),
      ) as List;
      result = response.map((res) => MatchData.fromJson(res)).toList();
    } catch (e) {
      debugPrint("Fetching get your matches data $e");
    }

    return result;
  }
}
