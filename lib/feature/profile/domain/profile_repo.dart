import 'package:crick_hub/feature/profile/data/profile_models.dart';

abstract class ProfileRepo {
  Future<ProfileInfo> getProfileInfo();
}
