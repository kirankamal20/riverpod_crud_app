import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository_pod.dart';
import 'package:riverpod_crud_app/features/register/view/ui_state/register_state.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';

class RegisterNotifier extends AutoDisposeAsyncNotifier<RegisterState> {
  @override
  FutureOr<RegisterState> build() {
    return InitialRegisterState();
  }

  Future<void> register(
      {required String email,
      required String password,
      required Function(String) onError,
      required Function(String) onSuccess}) async {
    state = AsyncData(RegisterLoadingState());
    try {
      final loginResult = await ref
          .watch(authenticationRepositoryPod)
          .register(email: email, password: password);

      loginResult.when((success) async {
        state = AsyncData(RegistrationSuccessState());
        onSuccess(success);
        // ref.read(autorouterprovider).replace(const LoginRoute());
      }, (error) {
        onError(error.toString());
        state = AsyncData(RegistrationErrorState(error.toString()));
      });
    } catch (e) {
      onError(e.toString());
      state = AsyncData(RegistrationErrorState(e.toString()));
    }
  }
}
