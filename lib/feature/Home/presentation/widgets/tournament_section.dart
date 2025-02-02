import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/Home/data/home_repository.dart';
import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';
import 'package:crick_hub/feature/tournament/presentation/pages/tournament_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentSection extends ConsumerStatefulWidget {
  const TournamentSection({super.key});

  @override
  ConsumerState<TournamentSection> createState() => _TournamentSectionState();
}

class _TournamentSectionState extends ConsumerState<TournamentSection> {
  bool loading = false;
  List<TournamentData> myTournaments = [];
  late int userId;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    loading = true;
    await getYourTournaments();
    loading = false;
  }

  void setUserId() async {
    ref.read(storageProvider).read(key: 'userId');
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loader()
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: myTournaments.length,
            itemBuilder: (context, index) {
              final tournament = myTournaments[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    color: Colors.grey.withValues(alpha: 0.17),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TournamentInfo(
                            data: tournament,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12.0,
                            top: 10,
                            right: 12,
                          ),
                          child: Row(
                            children: [
                              Text(
                                tournament.startDate ?? '',
                                style: CustomTextStyles.large.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 10),
                                  child: Center(
                                    child: Text(
                                      'to',
                                      style: CustomTextStyles.large.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                tournament.endDate ?? '',
                                style: CustomTextStyles.large.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12.0,
                            top: 10,
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tournament.name ?? '',
                                style: CustomTextStyles.large.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                tournament.place ?? '',
                                style: CustomTextStyles.large.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.network(
                            tournament.imageUrl ?? Constants.dummyImage,
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          height: 1,
                          thickness: 0.2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Future<void> getYourTournaments() async {
    final tournaments =
        await ref.read(homeRepositoryProvider).getYourTournaments();
    setState(() {
      myTournaments = tournaments;
    });
  }
}
