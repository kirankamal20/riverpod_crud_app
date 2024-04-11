import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:riverpod_crud_app/features/login/controller/login_notifier_pod.dart';
import 'package:riverpod_crud_app/features/login/view/widget/login_button.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';
import 'package:riverpod_crud_app/shared/helpers/global_helper.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with GlobalHelper {
  final formkey = GlobalKey<FormBuilderState>();
  void login() {
    if (formkey.currentState!.validate()) {
      final username = formkey.currentState!.fields["email"]!.value as String;
      final passsword =
          formkey.currentState!.fields["password"]!.value as String;
      ref.read(loginAsyncNotifierPod.notifier).login(
            email: username,
            password: passsword,
            onError: (String errorMessage) {
              showSnackBar(
                  errorMessage: errorMessage, backgroundColor: Colors.red);
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FormBuilder(
        key: formkey,
        initialValue: const {"email": "kiran21", 'password': "Kiran@123"},
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/login2.jpg",
              ),
            ),
            [
              "Login".text.size(50).bold.make(),
              [
                "Username"
                    .text
                    .size(16)
                    .fontWeight(FontWeight.w500)
                    .color(const Color(0xFF4E4E4E))
                    .make()
                    .p(8),
                FormBuilderTextField(
                  name: "email",
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color(0xFFD1D1D1), width: 1),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color(0xFF6F30C0), width: 1),
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ImageIcon(
                          AssetImage("assets/images/email_icon.png"),
                          color: Color(0xFF4E4E4E),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minHeight: 22,
                        minWidth: 22,
                      ),
                      hintText: "Username"),
                  style: const TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
              ].vStack(crossAlignment: CrossAxisAlignment.start),
              [
                "Password"
                    .text
                    .size(16)
                    .fontWeight(FontWeight.w500)
                    .color(const Color(0xFF4E4E4E))
                    .make()
                    .p(8),
                FormBuilderTextField(
                  name: "password",
                  obscureText: true,
                  // controller: passwordController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color(0xFFD1D1D1), width: 1),
                      ),
                      // contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color(0xFF6F30C0), width: 1),
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ImageIcon(
                          AssetImage("assets/images/password_icon.png"),
                          color: Color(0xFF4E4E4E),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minHeight: 22,
                        minWidth: 22,
                      ),
                      // suffix: IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     // passwordVisible!
                      //     //     ?
                      //     CupertinoIcons.eye_fill,
                      //     //  : CupertinoIcons.eye_slash_fill,
                      //     color: Color(0xFF6F30C0),
                      //   ),
                      //   constraints: const BoxConstraints(),
                      // ),
                      // suffixIconConstraints: const BoxConstraints(
                      //   minHeight: 10,
                      //   minWidth: 10,
                      // ),
                      hintText: "Password "),
                  // obscureText: !passwordVisible!,
                  obscuringCharacter: '●',
                  style: const TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
              ].vStack(crossAlignment: CrossAxisAlignment.start)
            ].vStack().pOnly(left: 30, right: 30),
            LoginButton(
              login: login,
            ).p(20),
            OutlinedButton(
              style: ButtonStyle(
                side: MaterialStatePropertyAll(
                  BorderSide(color: context.primaryColor),
                ),
              ),
              onPressed: () {
                ref.read(autorouterprovider).navigate(const MobileLoginRoute());
              },
              child: "Login With Mobile Number".text.bold.make(),
            ).w(context.screenWidth * 0.86).h(60),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                "Don't have an account ? ".text.gray500.bold.size(14).make(),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return TextButton(
                      onPressed: () {
                        ref
                            .read(autorouterprovider)
                            .navigate(const RegisterRoute());
                      },
                      child: "Register"
                          .text
                          // .color(const Color.fromARGB(255, 3, 3, 77))
                          .bold
                          .size(14)
                          .make(),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ).scrollVertical(),
    );
  }
}
