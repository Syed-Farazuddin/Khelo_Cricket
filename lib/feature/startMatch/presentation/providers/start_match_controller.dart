import 'package:crick_hub/feature/startMatch/data/repository/start_match_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_match_controller.g.dart';

@riverpod
class StartMatchController extends _$StartMatchController {
  @override
  void build() {
    return;
  }

  Future<void> fetchYourTeams() async {
    await ref.read(startMatchRepositoryProvider).fetchYourTeams();
  }
}
