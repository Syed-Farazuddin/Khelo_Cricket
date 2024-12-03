import 'package:crick_hub/common/widgets/button_list.dart';
import 'package:crick_hub/feature/profile/data/profile_models.dart';
import 'package:crick_hub/feature/profile/presentation/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  int active = 0;
  List<String> fields = ["Batting", "Bowling", "Fielding"];
  bool loading = false;
  late List<List<StatsItem>> stats = [[], [], []];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 80,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "lib/assets/images/profile.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Syed Farazuddin",
                                style: GoogleFonts.golosText(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "21 years (24-05-2003)",
                                style: GoogleFonts.golosText(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "All Rounder",
                                style: GoogleFonts.golosText(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Right hand Bat",
                                style: GoogleFonts.golosText(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Right arm Medium",
                                style: GoogleFonts.golosText(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Stats",
                          style: GoogleFonts.golosText(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonList(
                          list: fields,
                          active: active,
                          onTap: (val) {
                            setState(
                              () {
                                active = val;
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: stats[active].length,
                          itemBuilder: (builder, index) {
                            final StatsItem item = stats[active][index];
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.09),
                                  ),
                                  color: Colors.white.withOpacity(0.04)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.name,
                                    style: GoogleFonts.golosText(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item.stats,
                                    style: GoogleFonts.golosText(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> getProfileData() async {
    setState(() {
      loading = true;
    });
    ProfileInfo profile =
        await ref.read(profileProviderProvider.notifier).getProfileInfo();
    setState(() {
      stats = profile.stats.stats;
    });
    setState(() {
      loading = false;
    });
  }
}

// ignore: non_constant_identifier_names
Widget Fields({
  required String label,
  bool isActive = false,
  Function(bool value)? onTap,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 12,
    ),
    decoration: BoxDecoration(
      color: isActive
          ? Colors.grey.withOpacity(
              0.5,
            )
          : Colors.transparent,
      borderRadius: BorderRadius.circular(
        12,
      ),
    ),
    child: Text(
      label,
      style: GoogleFonts.golosText(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
