import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/models/team_details.dart';
import 'package:crick_hub/common/widgets/player_card.dart';
import 'package:crick_hub/core/colors/colors.dart';
import 'package:flutter/material.dart';

class ShowTeamInfo extends StatelessWidget {
  const ShowTeamInfo({super.key, required this.teamDetails});
  final TeamDetails teamDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            teamDetails.name ?? '',
            style: CustomTextStyles.subheadings,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Matches Played : ${teamDetails.matches.length}",
            style: CustomTextStyles.large,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Wins : ${teamDetails.wins}",
            style: CustomTextStyles.large,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Draws : ${teamDetails.draws}",
            style: CustomTextStyles.large,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Players",
            style: CustomTextStyles.large.copyWith(
              color: AppColors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (builder, index) {
              return PlayerCard(
                player: teamDetails.players[index],
                onTap: () {},
                color: Colors.black.withValues(alpha: 0.19),
                borderColor: Colors.black.withValues(alpha: 0.2),
                showSelectPlayerIcon: false,
              );
            },
            separatorBuilder: (builder, idx) => const SizedBox(
              height: 10,
            ),
            itemCount: teamDetails.players.length,
          ),
        ],
      ),
    );
  }
}
