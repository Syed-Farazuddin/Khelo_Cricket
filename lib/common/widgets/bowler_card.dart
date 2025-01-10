import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/image.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BowlerCard extends StatelessWidget {
  const BowlerCard({
    super.key,
    required this.bowler,
    required this.onTap,
  });
  final Players bowler;
  final Function(Players) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(bowler);
        context.pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(
            14,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Row(
                children: [
                  CustomImage(
                    image: bowler.image != null ||
                            bowler.image!.isNotEmpty ||
                            bowler.image == ""
                        ? bowler.image != ""
                            ? bowler.image!
                            : Constants.dummyImage
                        : Constants.dummyImage,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    bowler.name ?? "",
                    style: CustomTextStyles.mediumText,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
