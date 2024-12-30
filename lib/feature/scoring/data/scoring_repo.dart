import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/scoring/domain/scoring_repository.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
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
  Future<void> fetchMatchData() async {}

  @override
  Future<void> undoScore() async {}

  @override
  Future<UpdateScoringResponse> updateScore({
    required Updatescoring scoring,
    required int inningsId,
  }) async {
    UpdateScoringResponse res = UpdateScoringResponse(
      message: '',
      selectNewBowler: false,
      status: false,
    );
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
      res = UpdateScoringResponse.fromJson(result);
      if (result['success'] ?? false) {
        Toaster.onSuccess(message: res.message ?? '');
      } else {
        Toaster.onError(message: res.message ?? '');
      }
    } catch (e) {
      debugPrint("Error while updating score $e");
    }
    return res;
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
  Future<void> selectStrikers() async {}

  @override
  Future<InningsModel> fetchInningsData({required int inningsId}) async {
    InningsModel result = InningsModel(
      byes: 0,
      extras: 0,
      inningsid: 0,
      isCompleted: false,
      nonStrikerId: 0,
      oversPlayed: 0,
      strikerId: 0,
      totalNoBalls: 0,
      totalRuns: 0,
      totalWides: 0,
      bowlerId: 0,
      batting: TeamData(
        name: '',
        id: 0,
      ),
      bowling: TeamData(
        name: '',
        id: 0,
      ),
      bowler: PlayerBowlerScoreModel(
        player: Players(name: '', id: 0),
        score: BowlingScoreModel(),
      ),
      striker: PlayerScoreModel(
        player: Players(
          name: '',
          id: 0,
        ),
        score: ScoreModel(),
      ),
      nonStriker: PlayerScoreModel(
        player: Players(
          name: '',
          id: 0,
        ),
        score: ScoreModel(),
      ),
    );
    try {
      final response = await baseService.get(
        Network.getInningsData(
          inningsid: inningsId,
        ),
        options: Options(
          headers: {
            "Authorization": await storage.read(
              key: 'token',
            ),
          },
        ),
      );
      result = InningsModel.fromJson(response);
    } catch (e) {
      debugPrint('Error while fetching innings Data');
    }
    return result;
  }

  @override
  Future<InningsModel> endInnings({required int inningsId}) async {
    InningsModel result = InningsModel(
      byes: 0,
      extras: 0,
      inningsid: 0,
      isCompleted: false,
      nonStrikerId: 0,
      oversPlayed: 0,
      strikerId: 0,
      totalNoBalls: 0,
      totalRuns: 0,
      totalWides: 0,
      bowlerId: 0,
      bowling: TeamData(
        name: '',
        id: 0,
      ),
      batting: TeamData(
        name: '',
        id: 0,
      ),
      bowler: PlayerBowlerScoreModel(
        player: Players(name: '', id: 0),
        score: BowlingScoreModel(),
      ),
      striker: PlayerScoreModel(
        player: Players(
          name: '',
          id: 0,
        ),
        score: ScoreModel(),
      ),
      nonStriker: PlayerScoreModel(
        player: Players(
          name: '',
          id: 0,
        ),
        score: ScoreModel(),
      ),
    );
    try {
      final response = await baseService.get(
        Network.startNewInnings(),
        options: Options(
          headers: {
            "Authorization": await storage.read(
              key: 'token',
            ),
          },
        ),
      );
      result = InningsModel.fromJson(response);
    } catch (e) {
      debugPrint('Error while fetching innings Data');
    }
    return result;
  }
}
