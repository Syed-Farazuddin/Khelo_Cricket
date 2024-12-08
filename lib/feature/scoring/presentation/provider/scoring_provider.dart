import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scoring_provider.g.dart';

@riverpod
class ScoringProvider extends _$ScoringProvider {
  @override
  void build() {
    return;
  }

  Future<void> updateScoring() async {}

  Future<void> selectBatsman() async {}

  Future<void> selectBowler() async {}
}
