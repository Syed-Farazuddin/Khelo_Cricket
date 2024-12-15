import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/scoring/domain/scoring_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crick_hub/feature/scoring/data/scoring_models.dart';

final scoringRepositoryProvider = Provider((ref) {
  final baseService = ref.read(baseServiceProvider);
  final storage = ref.read(storageProvider);
  return ScoringRepo(
    baseService: baseService,
    storage: storage,
  );
});

class ScoringRepo extends ScoringRepository {
  ScoringRepo({
    required this.baseService,
    required this.storage,
  });

  final BaseService baseService;
  final Storage storage;
  @override
  Future<void> fetchInningsData() async {}

  Future<void> fetchMatchData() async {}

  @override
  Future<void> undoScore() async {}

  @override
  Future<void> updateScore({
    required Updatescoring scoring,
    required int inningsId,
  }) async {
    try {
      final score = scoring.toJson(scoring);
      final result = await baseService.post(
        Network.updateScore(
          inningsId: inningsId,
        ),
        body: score,
        options: Options(
          headers: {
            "Authorization": await storage.read(
              key: 'token',
            ),
          },
        ),
      );
      if (result['success']) {
        Toaster.onSuccess(
          message: "Synced",
        );
      }
    } catch (e) {
      debugPrint("Error while updating score $e");
    }
  }

  @override
  Future<void> batsmenOut() async {
    // TODO: implement batsmenOut
  }

  @override
  Future<void> selectBowler() async {
    // TODO: implement selectBowler
  }

  @override
  Future<void> selectStrikers() async {
    // TODO: implement selectStrikers
  }
}
