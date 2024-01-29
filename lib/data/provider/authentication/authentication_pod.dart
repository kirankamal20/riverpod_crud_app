import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/provider/authentication/authentication_provider.dart';
import 'package:riverpod_crud_app/data/provider/authentication/i_authentication_provider.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/shared/dio/dio_client_provider.dart';

final authenticationPod = Provider.autoDispose<IAuthenticationProvider>((ref) {
  return AuthenticationProvider(
      dio: ref.watch(dioProvider), iDbServiceService: ref.watch(dbServicePod));
});
