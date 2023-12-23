import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/login/controller/login_notifier_pod.dart';
import 'package:riverpod_crud_app/features/login/view/ui_state/login_state.dart';
import 'package:riverpod_crud_app/features/login/view/widget/custom_login_btn.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginButton extends ConsumerWidget {
  final Function() login;
  const LoginButton({super.key, required this.login});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginAsyncData = ref.watch(loginAsyncNotifierPod);
    return loginAsyncData.when(
      data: (data) {
        return switch (data) {
          InitialLoginState() =>
            CustomLoginElevatedButton(login: login, label: "Login"),
          LoginLoadingState() =>
            CustomLoginElevatedButton(login: login, label: "Loading"),
          LoginSuccessState() =>
            CustomLoginElevatedButton(login: login, label: "Success"),
          LoginErrorState() =>
            CustomLoginElevatedButton(login: login, label: "Error"),
        };
      },
      error: (error, stackTrace) => "error".text.make(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
