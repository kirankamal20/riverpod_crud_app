import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/shared/dio/default_api_error_handler.dart';

class DefaultAPIInterceptor extends Interceptor {
  DefaultAPIInterceptor(this.ref, {
    required this.dio,
  });
  final Dio dio;
  final AutoDisposeProviderRef<Object?> ref;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    defaultAPIErrorHandler(err, handler, dio,ref);
  }
}
