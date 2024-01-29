import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/main.dart';
import 'package:riverpod_crud_app/shared/dio/bad_certificate_fixer.dart';
import 'package:riverpod_crud_app/shared/dio/default_api_interceptor.dart';
import 'package:riverpod_crud_app/shared/dio/default_time_response_interceptor.dart';

import 'package:talker_dio_logger/talker_dio_logger.dart';

final dioProvider = Provider.autoDispose(
  (ref) {
    final dio = Dio();
    dio.options.baseUrl = 'https://fastapi-student-crud.onrender.com/';
    if (kDebugMode) {
      dio.interceptors.add(TimeResponseInterceptor());
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          final data = options.data;

          if (data is FormData) {
            ///print form data
            for (var item in data.fields) {
              talker.log('${item.key} : ${item.value}');
            }
          }
          handler.next(options);
        },
        
      ));
      dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
          ),
        ),
      );
    }

    dio.interceptors.addAll([
      DefaultAPIInterceptor(ref,dio: dio),
      RetryInterceptor(
        dio: dio,
        logPrint: talker.log, // specify log function (optional)
        // retry count (optional)
        retries: 2,
        retryDelays: [
          const Duration(seconds: 2),
          const Duration(seconds: 4),
          const Duration(seconds: 6),
        ],
        retryEvaluator: (error, i) {
          // only retry on DioError
          if (error.error is SocketException) {
            // only retry on timeout error
            return true;
          } else {
            return false;
          }
        },
      ),
    ]);
    fixBadCertificate(dio: dio);
    return dio;
  },
  name: 'dioProvider',
);
