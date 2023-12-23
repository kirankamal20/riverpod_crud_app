import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formkey = GlobalKey<FormBuilderState>();
  void login() {
    if (formkey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    var isDeskTop = ResponsiveBreakpoints.of(context).isDesktop;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          [
            "Login"
                .text
                .white
                .size(50)
                .bold
                .make()
                .centered()
                .box
                .color(const Color.fromARGB(255, 3, 3, 77))
                .withConstraints(
                  BoxConstraints(
                      maxWidth: double.infinity,
                      maxHeight: isDeskTop ? 400 : 526),
                )
                .make(),
          ].vStack(),
          FormBuilder(
            key: formkey,
            child: [
              FormBuilderTextField(
                name: "email",
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
                obscureText: true,
                // controller: passwordController,
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
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child:
                    //  isLoading
                    //     ?
                    //
                    //const SizedBox(
                    //         height: 20,
                    //         width: 20,
                    //         child: CircularProgressIndicator(
                    //           color: Colors.white,
                    //         ),
                    //       )
                    //     :
                    "Login".text.white.bold.size(25).make(),
              )
                  .h(50)
                  .w(context.screenWidth)
                  .pOnly(top: 20, right: 10, left: 10),
              const Gap(10),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  "Don't have an account ? ".text.gray500.bold.size(14).make(),
                  TextButton(
                    onPressed: () {},
                    child: "Register"
                        .text
                        .color(const Color.fromARGB(255, 3, 3, 77))
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
      ),
    );
  }
}
