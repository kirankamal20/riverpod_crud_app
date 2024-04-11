import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:riverpod_crud_app/features/login/controller/login_notifier_pod.dart';
import 'package:riverpod_crud_app/features/login/view/widget/login_button.dart';
import 'package:riverpod_crud_app/features/register/controller/register_notifier_pod.dart';
import 'package:riverpod_crud_app/features/register/view/widget/register_button.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';
import 'package:riverpod_crud_app/shared/helpers/global_helper.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> with GlobalHelper {
  final formkey = GlobalKey<FormBuilderState>();
  void register() {
    if (formkey.currentState!.validate()) {
      final username = formkey.currentState!.fields["email"]!.value as String;
      final passsword =
          formkey.currentState!.fields["password"]!.value as String;
      ref.read(registerAsyncNotifierPod.notifier).register(
            email: username,
            password: passsword,
            onError: (errorMessage) {
              showSnackBar(
                  errorMessage: errorMessage, backgroundColor: Colors.red);
            },
            onSuccess: (successMessage) {
              showSnackBar(
                  errorMessage: successMessage, backgroundColor: Colors.blue);
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDeskTop = ResponsiveBreakpoints.of(context).isDesktop;
    return Scaffold(
      // backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          [
            "Register"
                .text
                .white
                .size(50)
                .bold
                .make()
                .centered()
                .box
                .color(context.primaryColor)
                .withConstraints(
                  BoxConstraints(
                      maxWidth: double.infinity,
                      maxHeight: isDeskTop ? 400 : 526),
                )
                .make(),
            VxBox().height(500).make()
          ].vStack(),
          FormBuilder(
            key: formkey,
            child: [
              FormBuilderTextField(
                name: "email",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  labelText: "Enter the email",
                  prefixIcon: Icon(Icons.email),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
              ).pOnly(top: 45, right: 10, left: 10),
              FormBuilderTextField(
                name: "password",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                  label: Text("Enter the Password"),
                  prefixIcon: Icon(Icons.password),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
              ).pOnly(top: 17, right: 10, left: 10),
              RegisterButton(
                login: register,
              ),
              const Gap(10),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  "Already have an account ? "
                      .text
                      .gray500
                      .bold
                      .size(14)
                      .make(),
                  TextButton(
                    onPressed: () {
                      ref.read(autorouterprovider).replace(const LoginRoute());
                    },
                    child: "Login"
                        .text
                        // .color(const Color.fromARGB(255, 3, 3, 77))
                        .bold
                        .size(14)
                        .make(),
                  )
                ],
              )
            ]
                .vStack()
                .p(8)
                .box
                .withConstraints(const BoxConstraints(maxWidth: 900))
                .make()
                .card
                .white
                .withRounded(value: 20)
                .make()
                .positioned(
                  top: isDeskTop ? 300 : 390,
                  left: isDeskTop ? 150 : 30,
                  right: isDeskTop ? 150 : 30,
                ),
          )
        ],
      ).scrollVertical(),
    );
  }
}
