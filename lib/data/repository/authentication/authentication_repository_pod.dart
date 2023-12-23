import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/provider/authentication/authentication_pod.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository.dart';
import 'package:riverpod_crud_app/data/repository/authentication/i_authentication_repository.dart';

final authenticationRepositoryPod =
    Provider.autoDispose<IAuthenticationRepository>((ref) {
  return AuthenticationRepository(
      iAuthenticationProvider: ref.watch(authenticationPod));
});
