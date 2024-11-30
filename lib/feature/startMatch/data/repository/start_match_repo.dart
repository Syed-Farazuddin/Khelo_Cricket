import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
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

      return teams;
    } catch (e) {
      debugPrint("Error while fetching your teams");
    }
    return [];
  }

  @override
  Future<bool> addNewTeam({
    required String name,
  }) async {
    try {
      final Map<String, dynamic> response = await baseService.post(
        Network.createNewTeam(),
        options: Options(
          headers: {
            "Authorization": await storage.read(
              key: 'token',
            ),
          },
        ),
        body: {
          'teamName': name,
        },
      );
      debugPrint(response.toString());
      if (response['success'] == true) {
        Toaster.onSuccess(
          message: response['message'],
        );
        return true;
      } else {
        Toaster.onError(
          message: response['message'],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  @override
  Future<AddTeamResponse> addNewPlayer(
      {required int teamId, required String mobile}) async {
    try {
      final response = await baseService.post(
        Network.addNewPlayer(
          teamId: teamId,
        ),
        body: {
          'mobile': mobile,
        },
      );
      final result = AddTeamResponse.fromJson(response);
      if (response['status'] == true) {
        Toaster.onSuccess(
          message: response['message'],
        );
      }
      return result;
    } catch (e) {
      debugPrint('Error caused in add new player API $e');
    }
    return AddTeamResponse(
      playerExists: true,
      success: false,
      message: "Something Went Wrong",
    );
  }

  @override
  Future<AddTeamResponse> createNewPlayerAndAddInTeam({
    required int teamId,
    required String mobile,
    required String name,
  }) async {
    AddTeamResponse res = AddTeamResponse(
      playerExists: false,
      success: false,
      message: "Something Went Wrong",
    );
    try {
      final response =
          await baseService.post(Network.createPlayerAndAddInTeam(), body: {
        'mobile': mobile,
        'teamId': teamId,
        'name': name,
      });
      res = AddTeamResponse.fromJson(response);
      return res;
    } catch (e) {
      debugPrint("Error cause in creating player and adding in team $e");
    }
    return res;
  }
}
