import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pinput/pinput.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({super.key});

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  final smartAuth = SmartAuth();
  final mobilenumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    requestHint();
  }

  void requestHint() async {
    final res = await smartAuth.requestHint(
      isPhoneNumberIdentifierSupported: true,
      showCancelButton: true,
    );
    debugPrint('requestHint: $res');
    mobilenumberController.text = res?.id ?? "";
  }

  @override
  Widget build(BuildContext context) {
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
                "What is your \nphone number?".text.size(40).bold.make(),
                20.heightBox,
                "Please Enter your mobile number".text.size(18).make(),
              ].vStack().p(20),

              FormBuilderPhoneField(
                controller: mobilenumberController,
                name: 'phone_number',
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Phone Number',
                ),
                defaultSelectedCountryIsoCode: 'IN',
                priorityListByIsoCode: const ['IN'],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ).p(20),

              const Spacer(),

              Consumer(
                builder: (_, WidgetRef ref, __) {
                  return ElevatedButton(
                      onPressed: () {
                        ref
                            .read(autorouterprovider)
                            .navigate(const MobileOtpVerifyRoute());
                      },
                      child: const Text("CONTINUE"));
                },
              ).h(60).w(context.screenWidth * 0.9).centered()
            ],
          ),
        ),
      ),
    );
  }
}
