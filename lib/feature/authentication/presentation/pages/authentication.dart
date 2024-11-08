import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:crick_hub/feature/authentication/presentation/widgets/otp_form.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController controller = TextEditingController();
  bool showOtp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomInputField(
            label: "Enter Your Mobile Number",
            controller: controller,
            maxlength: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          showOtp
              ? const OtpFormWidget(
                  verifyOtp: "1234",
                )
              : const SizedBox.shrink(),
          !showOtp
              ? Custombutton(
                  onTap: () {
                    showOtp = true;
                  },
                  title: "Send OTP",
                  width: MediaQuery.of(context).size.width / 2,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
