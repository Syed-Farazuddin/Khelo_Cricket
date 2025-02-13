import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/network/network.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/scheduleMatch/domain/schedule_match_repo.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scheduleMatchRepositoryProvider =
    Provider<ScheduleMatchRepository>((ref) {
  BaseService baseService = ref.watch(baseServiceProvider);
  final storage = ref.watch(storageProvider);

  return ScheduleMatchRepository(baseService: baseService, storage: storage);
});

class ScheduleMatchRepository extends ScheduleMatchRepo {
  final BaseService baseService;
  final Storage storage;

  ScheduleMatchRepository({
    required this.baseService,
    required this.storage,
  });

  @override
  Future<bool> scheduleMatch({required StartMatchRequestBody req}) async {
    bool result = false;
    try {
      baseService.post(
        Network.scheduleYourMatch(),
      );
    } catch (e) {
      debugPrint("Error while scheduling match $e");
    }
    return result;
  }
}
