import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/match/domain/match_models.dart';
import 'package:crick_hub/feature/match/domain/match_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final matchDetailsRepositoryProvider = Provider<MatchRepository>((ref) {
  final baseService = ref.read(baseServiceProvider);
  final storage = ref.read(storageProvider);
  return MatchRepository(
    baseService: baseService,
    storage: storage,
  );
});

class MatchRepository extends MatchRepo {
  final BaseService baseService;
  final Storage storage;
  MatchRepository({
    required this.baseService,
    required this.storage,
  });

  @override
  Future<MatchOverviewModel> fetchMatchOverview({
    required int matchId,
  }) async {
    MatchOverviewModel data = MatchOverviewModel();
    try {
      final result = await baseService.get(
        Network.getMatchOverview(
          matchId: matchId,
        ),
        options: Options(
          headers: {
            "Authorization": await storage.read(
              key: 'token',
            ),
          },
        ),
      );
      debugPrint(result.toString());
      data = MatchOverviewModel.fromJson(result);
    } catch (e) {
      debugPrint("Error while fetching the match overview");
    }
    return data;
  }

  @override
  Future<List> fetchMatchDetailItems() async {
    List res = [];
    try {
      final result = await baseService.get(
        Network.getMatchDetailItems(),
      );
      debugPrint("result is ${result.toString()}");
      res = result;
    } catch (e) {
      debugPrint("Error while fetching the match overview");
    }
    return res;
  }
}
