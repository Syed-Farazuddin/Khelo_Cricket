import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/image.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BatmanCard extends StatelessWidget {
  const BatmanCard({
    super.key,
    required this.batsman,
    required this.onTap,
  });
  final Players batsman;
  final Function(Players) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(batsman);
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
                    image: batsman.image != null ||
                            batsman.image!.isNotEmpty ||
                            batsman.image == ""
                        ? batsman.image != ""
                            ? batsman.image!
                            : Constants.dummyImage
                        : Constants.dummyImage,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    batsman.name ?? "",
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
