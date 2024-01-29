import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';

Future<void> defaultAPIErrorHandler(
    DioException err,
    ErrorInterceptorHandler handler,
    Dio dio,
    final AutoDisposeProviderRef<Object?> ref) async {
  switch (err.type) {
    case DioExceptionType.connectionTimeout:
      handler.resolve(
        Response(
          data: {'detail': 'connect timeout error'},
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.sendTimeout:
      handler.resolve(
        Response(
          data: {'detail': 'sending data is slow'},
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.receiveTimeout:
      handler.resolve(
        Response(
          data: {'detail': 'receiving data is slow'},
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.badResponse:
      if (err.response!.statusCode == 404) {
        handler.resolve(
          Response(
            data: {
              'detail': 'server error: status code ${err.response!.statusCode}'
            },
            requestOptions: RequestOptions(path: err.requestOptions.path),
          ),
        );
      } else if (err.response!.statusCode == 401) {
        await ref.read(dbServicePod).removeToken();
        await ref.read(autorouterprovider).replaceAll([const LoginRoute()]);
        handler.resolve(
          Response(
            data: {'detail': 'Token Expired'},
            requestOptions: RequestOptions(path: err.requestOptions.path),
          ),
        );
      } else {
        handler.resolve(
          err.response ??
              Response(
                data: {'detail': 'response error'},
                requestOptions: err.requestOptions,
              ),
        );
      }
    case DioExceptionType.cancel:
      handler.resolve(
        Response(
          data: {'detail': 'user cancelled request'},
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.badCertificate:
      handler.resolve(
        Response(
          data: {'detail': 'Bad certificate'},
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.connectionError:
      handler.resolve(
        Response(
          data: {'detail': 'No Internet'},
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.unknown:
      handler.resolve(
        Response(
          data: {'detail': 'other error data:${err.response?.data}'},
          requestOptions: err.requestOptions,
        ),
      );
  }
}
