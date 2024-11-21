import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTeamPlayer extends StatefulWidget {
  const SelectTeamPlayer({
    super.key,
    required this.controller,
    required this.players,
    required this.selectedPlayers,
    required this.teamName,
  });

  final String teamName;
  final List players;
  final TextEditingController controller;
  final List<int> selectedPlayers;

  @override
  State<SelectTeamPlayer> createState() => _SelectTeamPlayerState();
}

class _SelectTeamPlayerState extends State<SelectTeamPlayer> {
  int active = 0;
  final List<String> fields = ["Using mobile Number", "Without Mobile"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team :  ${widget.teamName}",
            style: GoogleFonts.golosText(
              color: Colors.white.withOpacity(0.9),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Add New Player",
            style: GoogleFonts.golosText(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonList(
            list: fields,
            onTap: (value) {
              setState(() {
                active = value;
              });
            },
            active: active,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                  controller: widget.controller,
                  maxlength: 10,
                  label: "Add new player ${fields[active]}",
                ),
              ),
              Custombutton(
                onTap: () {
                  // Take the number from controller
                  // Fetch the user associated from number
                  // Add the player in the previous added
                  // Can also add it in selectedPlayers
                  // That's it
                },
                width: 80.0,
                showIcon: true,
                title: "Add",
                icon: Icons.add,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Previously added players",
            style: GoogleFonts.golosText(
              color: Colors.white.withOpacity(0.7),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.players.length,
            itemBuilder: (builder, index) {
              Players player = widget.players[index];
              return AnimatedContainer(
                duration: const Duration(
                  microseconds: 1000,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: widget.selectedPlayers.contains(player.id)
                      ? Colors.blue
                      : Colors.white.withOpacity(
                          0.1,
                        ),
                  border: Border.all(
                    color: widget.selectedPlayers.contains(player.id)
                        ? Colors.blue
                        : Colors.white.withOpacity(
                            0.1,
                          ),
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
                                  player.image ?? "",
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
                            player.name ?? "",
                            style: GoogleFonts.golosText(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.selectedPlayers.contains(player.id)) {
                            setState(() {
                              widget.selectedPlayers.remove(player.id);
                            });
                          } else if (widget.selectedPlayers.length <= 11) {
                            setState(() {
                              widget.selectedPlayers.add(
                                player.id,
                              );
                            });
                          } else {
                            Toaster.onError(
                              message: "11 Players are already selected",
                            );
                          }
                        },
                        child: const Text(
                          "Select",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
