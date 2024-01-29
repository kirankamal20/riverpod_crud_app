import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_service.dart';
import 'package:riverpod_crud_app/data/service/db_service/i_db_service_service.dart';

final dbServicePod = Provider.autoDispose<IDbServiceService>((ref) {
  return DbServiceService(userBox: ref.watch(userBox));
});
final userBox = Provider.autoDispose<Box>((ref) {
  return throw UnimplementedError();
});
