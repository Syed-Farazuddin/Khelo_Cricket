import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/common/widgets/show_teams.dart';
import 'package:crick_hub/core/storage/storage.dart';
import 'package:crick_hub/feature/tournament/data/tournament_repository.dart';
import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';
import 'package:crick_hub/feature/tournament/presentation/widgets/tournament_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentInfo extends ConsumerStatefulWidget {
  const TournamentInfo({
    super.key,
    required this.data,
  });
  final TournamentData data;

  @override
  ConsumerState<TournamentInfo> createState() => _TournamentInfoState();
}

class _TournamentInfoState extends ConsumerState<TournamentInfo> {
  List items = [];
  late int userId;
  bool loading = false;
  int active = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> setUserId() async {
    final id = await ref.read(storageProvider).read(key: 'userId');
    setState(() {
      userId = int.parse(id ?? "");
    });
  }

  void init() async {
    loading = true;
    await setUserId();
    await getTournamentItems();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loading
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 10,
                    ),
                    child: Text(
                      widget.data.name ?? "",
                      style: CustomTextStyles.large.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(0),
                    child: Image.network(
                      fit: BoxFit.fitWidth,
                      widget.data.imageUrl ?? Constants.dummyImage,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (userId == widget.data.createdById)
                    TournamentAdmin(
                      tournamentId: widget.data.id ?? 0,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 10,
                    ),
                    child: ButtonList(
                      list: items,
                      onTap: (value) {
                        setState(() {
                          active = value;
                        });
                      },
                      active: active,
                    ),
                  ),
                  ShowTeams(
                    teams: widget.data.teams,
                    selectTeam: (val) {},
                    selectedTeam: 0,
                  )
                ],
              ),
            ),
    );
  }

  Future<void> getTournamentItems() async {
    final result =
        await ref.read(tournamentRepositoryProvider).getTournamentItems();
    setState(() {
      items = result;
    });
  }

  Future<void> getTournamentInfo() async {
    final result =
        await ref.read(tournamentRepositoryProvider).getTournamentItems();
    setState(() {
      items = result;
    });
  }
}
