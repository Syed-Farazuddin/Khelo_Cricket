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
    return await ref.read(startMatchRepositoryProvider).fetchYourTeams();
  }
}
