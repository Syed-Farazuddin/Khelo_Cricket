import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/startTournament/domain/tournament_models.dart';
import 'package:crick_hub/feature/startTournament/domain/tournament_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tournamentRepositoryProvider = Provider<TournamentRepository>((ref) {
  final baseService = ref.read(baseServiceProvider);
  final storage = ref.read(storageProvider);
  return TournamentRepository(
    baseService: baseService,
    storage: storage,
  );
});

class TournamentRepository extends TournamentRepo {
  final BaseService baseService;
  final Storage storage;
  TournamentRepository({
    required this.baseService,
    required this.storage,
  });

  @override
  Future<bool> registerTournament(RegisterTournamentRequest request) async {
    bool result = false;
    try {
      Options options = await authorization();
      final response = await baseService.post(
        Network.registerTournament(),
        body: request.toJson(),
        options: options,
      );
      result = response;
    } catch (e) {
      debugPrint("Error while registering for tournament $e");
    }
    return result;
  }

  Future<Options> authorization() async {
    final options = Options(
      headers: {
        "Authorization": await storage.read(
          key: 'token',
        ),
      },
    );
    return options;
  }
}
