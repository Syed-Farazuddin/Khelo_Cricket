import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/display_players.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowRoles extends ConsumerStatefulWidget {
  const ShowRoles({
    super.key,
    required this.role,
    required this.path,
    required this.networkUrl,
    required this.isStriker,
    required this.isNonStriker,
    required this.isBowler,
    required this.player,
    required this.data,
    required this.ontap,
  });
  final String role;
  final String path;
  final String networkUrl;
  final bool isStriker;
  final bool isNonStriker;
  final bool isBowler;
  final Players player;
  final Function(Players player) ontap;
  final MatchData data;

  @override
  ConsumerState<ShowRoles> createState() => _ShowRolesState();
}

class _ShowRolesState extends ConsumerState<ShowRoles> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => DisplayPlayers(
              data: widget.data,
              selectBatman: widget.isStriker || widget.isNonStriker,
              onTap: widget.ontap,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              widget.role,
              style: GoogleFonts.golosText(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.path.startsWith("http")
                ? Image.network(
                    widget.path,
                    fit: BoxFit.contain,
                    height: 200,
                    width: 150,
                  )
                : Image.asset(
                    'lib/assets/images/cricket.jpg',
                    fit: BoxFit.contain,
                    width: 150,
                    height: 150,
                  ),
          ],
        ),
      ),
    );
  }
}
