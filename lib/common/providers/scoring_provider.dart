import 'package:crick_hub/common/models/scoring_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentBowlerProvider = StateProvider<BowlerDetails>(
  (ref) => BowlerDetails(),
);

final inningsProvider = StateProvider((ref) => 0);

final matchProvider = StateProvider((ref) => 0);

final currentOverProvider = StateProvider<OverDetails>(
  (ref) => OverDetails(),
);
