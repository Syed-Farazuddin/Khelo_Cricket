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
              ? OtpFormWidget(
                  mobile: controller.text,
                )
              : const SizedBox.shrink(),
          !showOtp
              ? Custombutton(
                  onTap: () async {
                    await sendOtp(mobile: controller.text);
                  },
                  title: "Send OTP",
                  width: MediaQuery.of(context).size.width / 2,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Future<void> sendOtp({required String mobile}) async {
    final result =
        await ref.read(authProviderProvider.notifier).sendOtp(mobile: mobile);
    debugPrint(result.toString());
    setState(() {
      showOtp = result;
    });
  }
}
