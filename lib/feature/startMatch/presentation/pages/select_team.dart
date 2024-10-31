import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/feature/startMatch/data/models/players.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTeam extends StatefulWidget {
  const SelectTeam({
    super.key,
    required this.teamName,
  });
  final String teamName;
  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> {
  final List players = [
    Players(
      name: "Syed Farazuddin",
      id: 1,
      image: "http://surl.li/glzedz",
    ),
    Players(
      name: "Shaik Anjum",
      id: 1,
      image: "http://surl.li/vaenjj",
    ),
    Players(
      name: "Rabada",
      id: 1,
      image: "http://surl.li/upxncu",
    )
  ];
  int _active = 0;
  final List<String> fields = ["Using mobile Number", "Without Mobile"];
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.teamName,
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
                    _active = value;
                  });
                },
                active: _active,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomInputField(
                      controller: _controller,
                      maxlength: 10,
                      label: "Add new player ${fields[_active]}",
                    ),
                  ),
                  Custombutton(
                    onTap: () {},
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: players.length,
                itemBuilder: (builder, index) {
                  Players player = players[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(
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
                                      player.image,
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
                                player.name,
                                style: GoogleFonts.golosText(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
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
        ),
      ),
    );
  }
}
