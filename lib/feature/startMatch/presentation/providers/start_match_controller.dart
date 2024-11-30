import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/data/repository/start_match_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_match_controller.g.dart';

@riverpod
class StartMatchController extends _$StartMatchController {
  @override
  void build() {
    return;
  }

  Future<List<Team>> fetchYourTeams() async {
    final teams = await ref.read(startMatchRepositoryProvider).fetchYourTeams();
    return teams;
  }

  Future<void> addNewTeam({required String name}) async {
    await ref.read(startMatchRepositoryProvider).addNewTeam(name: name);
  }

  Future<AddTeamResponse> addNewPlayer({
    required String number,
    required int teamId,
  }) async {
    return await ref.read(startMatchRepositoryProvider).addNewPlayer(
          teamId: teamId,
          mobile: number,
        );
  }

  Future<AddTeamResponse> createNewPlayerAndAddInTeam({
    required String mobile,
    required int teamId,
    required String name,
  }) async {
    return await ref
        .read(startMatchRepositoryProvider)
        .createNewPlayerAndAddInTeam(
          teamId: teamId,
          mobile: mobile,
          name: name,
        );
  }
}
