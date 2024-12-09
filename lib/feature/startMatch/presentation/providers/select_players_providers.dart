import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final striker = StateProvider<Players>((ref) {
  return Players(
    name: '',
    id: 0,
  );
});

final nonStriker = StateProvider<Players>((ref) {
  return Players(name: '', id: 0);
});

final bowler = StateProvider<Players>((ref) {
  return Players(name: '', id: 0);
});
