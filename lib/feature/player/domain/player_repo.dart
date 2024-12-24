import 'package:crick_hub/feature/player/domain/player_models.dart';

abstract class PlayerRepo {
  Future<void> saveUserDetails({
    required UserDetails details,
  });
}
