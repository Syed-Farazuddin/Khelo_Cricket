import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/feature/authentication/presentation/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:crick_hub/feature/authentication/presentation/widgets/sms_retriever.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class OtpFormWidget extends ConsumerStatefulWidget {
  const OtpFormWidget({
    super.key,
    required this.mobile,
    required this.isNewPlayer,
  });
  final String mobile;
  final bool isNewPlayer;
  @override
  ConsumerState<OtpFormWidget> createState() => _OtpFormWidgetState();
}

class _OtpFormWidgetState extends ConsumerState<OtpFormWidget> {
  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();

    smsRetriever = SmsRetrieverImpl(
      SmartAuth(),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.white;
    const borderColor = Colors.grey;

    final defaultPinTheme = PinTheme(
      width: MediaQuery.of(context).size.width * 0.2,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              smsRetriever: smsRetriever,
              controller: pinController,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('pin controller ${pinController.text}');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value ');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 0, 0),
                  ),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(
                    color: focusedBorderColor,
                  ),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            child: Custombutton(
              onTap: () async {
                focusNode.unfocus();
                debugPrint("Otp text is  ${pinController.text}");
                bool res = await verifyOtp(
                  mobile: widget.mobile,
                  otp: pinController.text,
                  isNewplayer: widget.isNewPlayer,
                );
                if (res) {
                  if (widget.isNewPlayer) {
                    context.goNamed('/playerDetails');
                    return;
                  }
                  context.goNamed('/home');
                }
              },
              title: "Verify Otp",
              width: 300,
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> fetchUserDetails() async {
  //   String mobile = widget.mobile;
  //   final user = await ref
  //       .read(authProviderProvider.notifier)
  //       .verifyOtp(mobile: mobile, otp: '\', isNewPlayer: true);
  // }

  Future<bool> verifyOtp({
    required String mobile,
    required String otp,
    required bool isNewplayer,
  }) async {
    bool result = await ref
        .read(authProviderProvider.notifier)
        .verifyOtp(mobile: mobile, otp: otp, isNewPlayer: isNewplayer);
    return result;
  }
}
