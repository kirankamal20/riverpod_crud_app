import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/main.dart';
import 'package:riverpod_crud_app/shared/api_client/dio_default_interceptor.dart';
import 'package:riverpod_crud_app/shared/api_client/dio_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = "https://studentcrudfastapi-production.up.railway.app/";
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
    // DefaultInterceptor(),
    // CustomInterceptors()
  ]);
  return dio;
});
