import 'package:crick_hub/common/constants/constants.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
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
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  '${Constants.assetImagepath}landing.jpg',
                ),
              ),
            ),
            child: SafeArea(
              minimum: const EdgeInsets.only(top: 70),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: buildForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomInputField(
          label: "Enter Your Mobile Number",
          controller: controller,
          maxlength: 10,
        ),
        const SizedBox(height: 20),
        if (showOtp)
          OtpFormWidget(
            mobile: controller.text,
            isNewPlayer: isNewPlayer,
          ),
        if (!showOtp)
          Custombutton(
            onTap: () async {
              await sendOtp(mobile: controller.text);
            },
            title: "Send OTP",
            width: MediaQuery.of(context).size.width / 2,
          ),
      ],
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
