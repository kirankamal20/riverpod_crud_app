import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/sign_out_btn/controller/notifier/sign_out_btn_notifier.dart';
import 'package:riverpod_crud_app/features/sign_out_btn/view/ui_state/sign_out_btn_state.dart';
import 'package:velocity_x/velocity_x.dart';

class SignOutButtonView extends ConsumerWidget {
  const SignOutButtonView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signOutBtnAsynData = ref.watch(signOutBtnAsyncNotifierPod);
    return signOutBtnAsynData.when(
      data: (data) => switch (data) {
        InitialSignOutBtnState() => ElevatedButton(
                onPressed: () {
                  ref.read(signOutBtnAsyncNotifierPod.notifier).signOut();
                },
                child: const Text("Sign Out"))
            .w(context.screenWidth * 0.8)
            .h(55),
        SignOutBtnLoadingState() => ElevatedButton(
                onPressed: () {},
                child: const CircularProgressIndicator().h(30).w(30))
            .w(context.screenWidth * 0.8)
            .h(55),
        SignOutBtnSuccessState() => ElevatedButton(
                onPressed: () {}, child: "Success".text.size(20).make())
            .w(context.screenWidth * 0.8)
            .h(55),
        SignOutBtnErrorState() => ElevatedButton(
                onPressed: () {}, child: "Something Wrong".text.size(20).make())
            .w(context.screenWidth * 0.8)
            .h(55),
      },
      error: (error, stackTrace) => ElevatedButton(
              onPressed: () {}, child: "Something Wrong".text.size(20).make())
          .w(context.screenWidth * 0.8)
          .h(55),
      loading: () => ElevatedButton(
              onPressed: () {},
              child: const CircularProgressIndicator().h(30).w(30))
          .w(context.screenWidth * 0.8)
          .h(55),
    );
  }
}
