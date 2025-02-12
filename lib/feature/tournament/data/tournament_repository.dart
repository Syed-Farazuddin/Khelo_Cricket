import 'package:crick_hub/common/models/team_details.dart';
import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';
import 'package:crick_hub/feature/tournament/domain/tournament_repo.dart';
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
  Future<TournamentData> registerTournament(
    RegisterTournamentRequest request,
  ) async {
    TournamentData result = TournamentData();
    try {
      Options options = await authorization();
      final response = await baseService.post(
        Network.registerTournament(),
        body: request.toJson(),
        options: options,
      );

      result = TournamentData.fromJson(response);
    } catch (e) {
      debugPrint("Error while registering for tournament $e");
    }
    return result;
  }

  @override
  Future<List<Team>> searchForTeams({
    required String teamName,
  }) async {
    List<Team> teams = [];
    try {
      Options options = await authorization();
      final response = await baseService.get(
        Network.searchTeams(name: teamName),
        options: options,
      ) as List;

      teams = response.map((r) => Team.fromJson(r)).toList();
    } catch (e) {
      debugPrint("Error while registering for tournament $e");
    }
    return teams;
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

  @override
  Future<List> getTournamentItems() async {
    List items = [];
    try {
      Options options = await authorization();
      final result = await baseService.get(
        Network.getTournamentItems(),
        options: options,
      ) as List;
      items = result;
    } catch (e) {
      debugPrint("Error while fetching tournament items");
    }
    return items;
  }

  @override
  Future<bool> addNewTeam({
    required String? teamName,
    required int tournamentId,
    required int? teamId,
  }) async {
    bool res = false;
    try {
      Options options = await authorization();
      final result = await baseService.post(
          Network.addNewTeam(
            id: tournamentId,
          ),
          options: options,
          body: {
            'teamName': teamName ?? '',
            'teamId': teamId ?? 0,
          });
      if (result['success']) {
        res = true;
      }
    } catch (e) {
      debugPrint("Error while fetching tournament items");
    }
    return res;
  }

  @override
  Future<TeamDetails> fetchTeamDetails({required int id}) async {
    TeamDetails teamDetails = TeamDetails();
    try {
      Options options = await authorization();
      final result = await baseService.get(
        Network.fetchTeamDetails(id: id),
        options: options,
      );
      teamDetails = TeamDetails.fromJson(result);
      debugPrint("Fetched team details");
    } catch (e) {
      debugPrint("Error while fetching team Details");
    }
    return teamDetails;
  }

  @override
  Future getTournamentInfo({required int id}) async {
    try {
      Options options = await authorization();
      final result = await baseService.get(
        Network.getTournamentInfo(id: id),
        options: options,
      );
      debugPrint(result.toString());
    } catch (e) {
      debugPrint("Error while fetching tournament details");
    }
  }
}
