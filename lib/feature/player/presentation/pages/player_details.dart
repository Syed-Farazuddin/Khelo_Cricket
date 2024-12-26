import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/feature/player/data/player_repository.dart';
import 'package:crick_hub/feature/player/domain/player_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class PlayerDetails extends ConsumerWidget {
  const PlayerDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter Your Name",
              style: CustomTextStyles.heading,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
              },
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        50,
                      ),
                    ),
                    child: SvgPicture.asset(
                      "lib/assets/svgs/profile.svg",
                      height: 70,
                      // width: 60,
                    ),
                  ),
                  const Positioned(
                    top: 6,
                    right: 10,
                    child: Icon(
                      Icons.camera_alt_sharp,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomInputField(
              controller: controller,
              label: "Enter Your name",
              textAllowed: true,
            ),
            Custombutton(
              onTap: () async {
                await ref.read(playerRepositoryProvider).saveUserDetails(
                      details: UserDetails(
                        id: 1,
                        imageUrl: "",
                        name: controller.text,
                        age: 20,
                        dob: '',
                      ),
                    );
              },
              title: "Save",
              color: Colors.blue,
              textColor: Colors.white,
              width: MediaQuery.of(context).size.width / 2,
            )
          ],
        ),
      ),
    );
  }

  Future<void> saveDetails() async {}
}
