import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository_pod.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/features/login/view/ui_state/login_state.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';

class LoginNotifier extends AutoDisposeAsyncNotifier<LoginState> {
  @override
  FutureOr<LoginState> build() {
    return InitialLoginState();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = AsyncData(LoginLoadingState());
    try {
      final loginResult = await ref
          .watch(authenticationRepositoryPod)
          .login(email: email, password: password);

      loginResult.when((success) async {
        await ref.watch(dbServicePod).setToken(token: success);
        state = AsyncData(LoginSuccessState());

        ref.read(autorouterprovider).navigate(const HomeRoute());
      }, (error) {
        state = AsyncData(LoginErrorState(error.toString()));
      });
    } catch (e) {
      state = AsyncData(LoginErrorState(e.toString()));
    }
  }
}
