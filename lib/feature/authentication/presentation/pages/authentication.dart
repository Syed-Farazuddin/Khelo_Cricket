import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/constants/text_styles.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/core/colors/colors.dart';
import 'package:crick_hub/feature/authentication/presentation/provider/auth_provider.dart';
import 'package:crick_hub/feature/authentication/presentation/widgets/otp_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationPage extends ConsumerStatefulWidget {
  const AuthenticationPage({super.key});

  @override
  ConsumerState<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends ConsumerState<AuthenticationPage> {
  final TextEditingController controller = TextEditingController();
  bool showOtp = false;
  bool isNewPlayer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            '${Constants.assetImagepath}landing.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          SafeArea(
            bottom: false,
            top: false,
            minimum: const EdgeInsets.only(top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: Text(
                    "Crickhub",
                    style: CustomTextStyles.largeText.copyWith(
                      color: AppColors.purple,
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                    ),
                  ),
                ),
                buildForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withValues(alpha: 0.9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              CustomInputField(
                label: "Enter Your Mobile Number",
                controller: controller,
                maxlength: 10,
              ),
              const SizedBox(height: 20),
              if (!showOtp)
                Custombutton(
                  onTap: () async {
                    await sendOtp(mobile: controller.text);
                  },
                  title: "Send OTP",
                  width: MediaQuery.of(context).size.width / 2,
                ),
            ],
          ),
          if (showOtp)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: OtpFormWidget(
                mobile: controller.text,
                isNewPlayer: isNewPlayer,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> sendOtp({required String mobile}) async {
    if (mobile.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(mobile)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid 10-digit mobile number")),
      );
      return;
    }

    try {
      final result =
          await ref.read(authProviderProvider.notifier).sendOtp(mobile: mobile);
      debugPrint(result.toString());
      setState(() {
        showOtp = result.status ?? false;
        isNewPlayer = result.field ?? false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send OTP. Please try again.")),
      );
    }
  }
}
