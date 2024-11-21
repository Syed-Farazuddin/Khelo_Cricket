import 'package:crick_hub/feature/profile/data/profile_models.dart';
import 'package:crick_hub/feature/profile/data/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileProvider extends _$ProfileProvider {
  @override
  void build() {
    return;
  }

  Future<ProfileInfo> getProfileInfo() async {
    return ref.read(profileRepositoryProvider).getProfileInfo();
  }
}
