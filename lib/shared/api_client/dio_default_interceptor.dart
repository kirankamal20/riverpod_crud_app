import 'package:dio/dio.dart';
import 'package:riverpod_crud_app/shared/api_client/dio_error_handler.dart';

class DefaultInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    defaultAPIErrorHandler(err, handler);
    super.onError(err, handler);
  }
}
