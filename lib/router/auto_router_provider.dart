import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/router/router.dart';

final autorouterprovider = Provider.autoDispose<AppRouter>((ref) {
  return AppRouter(iDbServiceService: ref.watch(dbServicePod));
});
