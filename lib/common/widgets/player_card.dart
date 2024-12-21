import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard({
    super.key,
    required this.player,
    required this.onTap,
    required this.color,
    required this.borderColor,
  });
  final Players player;
  final Function() onTap;
  final Color color;
  final Color borderColor;

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(
          microseconds: 1000,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: widget.borderColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Image.network(
                          widget.player.image == "null"
                              ? Constants.dummyImage
                              : widget.player.image ?? "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.player.name ?? "",
                    style: GoogleFonts.golosText(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                child: widget.player.selected
                    ? Image.asset(
                        "lib/assets/images/selected.png",
                        height: 30,
                        width: 30,
                      )
                    : const Text(
                        "Select",
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
