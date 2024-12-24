import 'package:crick_hub/feature/player/domain/player_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider(
  (ref) => UserDetails(id: 0, imageUrl: '', name: '', age: 0, dob: ''),
);
