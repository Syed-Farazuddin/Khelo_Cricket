import 'package:crick_hub/feature/match/data/match_repository.dart';
import 'package:crick_hub/feature/match/presentation/pages/match_details.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'match_detail_controller.g.dart';

@riverpod
class MatchDetailController extends _$MatchDetailController {
  @override
  void build() {
    return;
  }

  Future<MatchData> fetchMatchOverview({
    required int matchId,
  }) async {
    return ref
        .read(matchDetailsRepositoryProvider)
        .fetchMatchOverview(matchId: matchId);
  }

  Future<List> fetchMatchDetailItems() async {
    return ref.read(matchDetailsRepositoryProvider).fetchMatchDetailItems();
  }
}