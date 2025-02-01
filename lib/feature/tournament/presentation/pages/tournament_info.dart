import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/feature/tournament/domain/tournament_models.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.data.name ?? "",
                style: CustomTextStyles.subheadings,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
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
            ButtonList(
              list: ['Matches', "Teams", "Points Table", "Leaderboard"],
              onTap: (v) {},
              active: 0,
            )
          ],
        ),
      ),
    );
  }

  Future<void> getTournamentItems() async {}
}
