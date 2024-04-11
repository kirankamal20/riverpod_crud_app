import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/features/sign_out_btn/view/ui_state/sign_out_btn_state.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';

class SignOutButtonNotifier extends AutoDisposeAsyncNotifier<SignOutBtnState> {
  @override
  FutureOr<SignOutBtnState> build() {
    return InitialSignOutBtnState();
  }

  void signOut() async {
    state = AsyncData(SignOutBtnLoadingState());
    await ref.read(dbServicePod).removeToken();
    state = AsyncData(SignOutBtnSuccessState());
    ref.read(autorouterprovider).replace(const LoginRoute());
  }
}

final signOutBtnAsyncNotifierPod =
    AsyncNotifierProvider.autoDispose<SignOutButtonNotifier, SignOutBtnState>(
        SignOutButtonNotifier.new);
