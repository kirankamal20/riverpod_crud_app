import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class MobileOtpVerifyPage extends StatefulWidget {
  const MobileOtpVerifyPage({super.key});

  @override
  State<MobileOtpVerifyPage> createState() => _MobileOtpVerifyPageState();
}

class _MobileOtpVerifyPageState extends State<MobileOtpVerifyPage> {
  final pinputController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final smartAuth = SmartAuth();
  @override
  void initState() {
    super.initState();
    getAppSignature();
    userConsent();
  }

  @override
  void dispose() {
    pinputController.dispose();
    focusNode.dispose();
    smartAuth.removeSmsListener();

    super.dispose();
  }

  void getAppSignature() async {
    final res = await smartAuth.getAppSignature();
    debugPrint('Signature: $res');
  }

  void userConsent() async {
    debugPrint('userConsent: ');
    final res = await smartAuth.getSmsCode(useUserConsentApi: true);
    userConsent();
    if (res.codeFound) {
      pinputController.text = res.code!;
      pinputController.selection = TextSelection.fromPosition(
        TextPosition(offset: pinputController.text.length),
      );
    } else {
      debugPrint('userConsent failed: $res');
    }
    debugPrint('userConsent: $res');
  }

  void smsRetriever() async {
    final res = await smartAuth.getSmsCode();
    smsRetriever();
    if (res.codeFound) {
      pinputController.text = res.code!;
      pinputController.selection = TextSelection.fromPosition(
        TextPosition(offset: pinputController.text.length),
      );
    } else {
      debugPrint('smsRetriever failed: $res');
    }
    debugPrint('smsRetriever: $res');
  }

  void removeSmsListener() {
    smartAuth.removeSmsListener();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromARGB(255, 3, 3, 77);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromARGB(255, 3, 3, 77);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                  )),
              // Image.asset("assets/images/login.jpg"),
              [
                "Verify phone\nnumber".text.size(40).bold.make(),
                20.heightBox,
                "Check your SMS messages. We've sent you\nthe PIN at 8113887254"
                    .text
                    .size(18)
                    .make(),
              ].vStack(crossAlignment: CrossAxisAlignment.start).p(10),
              Directionality(
                // Specify direction if desired
                textDirection: TextDirection.ltr,
                child: Pinput(
                  focusNode: focusNode,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  // validator: (value) {
                  //   return value == '2222' ? null : 'Pin is incorrect';
                  // },
                  // onClipboardFound: (value) {
                  //   debugPrint('onClipboardFound: $value');
                  //   pinController.setText(value);
                  // },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
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
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(19),
                      border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ).centered().pOnly(top: 30),
              const Spacer(),

              [
                "Didn't receive SMS ?"
                    .text
                    .size(16)
                    .bold
                    .make()
                    .objectCenterLeft()
                    .p(30),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return ElevatedButton(
                        onPressed: () {}, child: const Text("VERIFY"));
                  },
                ).h(60).w(context.screenWidth * 0.9).centered()
              ].vStack()
            ],
          ),
        ),
      ),
    );
  }
}
