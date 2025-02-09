import 'package:crick_hub/core/network/base_service.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/scheduleMatch/domain/schedule_match_repo.dart';
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
}
