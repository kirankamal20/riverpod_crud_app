import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/login/controller/login_notifier_pod.dart';
import 'package:riverpod_crud_app/features/login/view/ui_state/login_state.dart';
import 'package:riverpod_crud_app/features/login/view/widget/custom_login_btn.dart';
import 'package:riverpod_crud_app/features/register/controller/register_notifier_pod.dart';
import 'package:riverpod_crud_app/features/register/view/ui_state/register_state.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterButton extends ConsumerWidget {
  final Function() login;
  const RegisterButton({super.key, required this.login});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerAsyncData = ref.watch(registerAsyncNotifierPod);
    return registerAsyncData.when(
      data: (data) {
        return switch (data) {
          InitialRegisterState() =>
            CustomRegisterElevatedButton(login: login, label: "Register"),
          RegisterLoadingState() => CustomRegisterElevatedButton(
              login: login,
              label: "Loading",
              isLoading: true,
            ),
          RegistrationSuccessState() =>
            CustomRegisterElevatedButton(login: login, label: "Success"),
          RegistrationErrorState() =>
            CustomRegisterElevatedButton(login: login, label: "Error"),
        };
      },
      error: (error, stackTrace) => "error".text.make(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
