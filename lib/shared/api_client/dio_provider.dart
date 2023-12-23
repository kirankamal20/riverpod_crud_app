import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = "https://studentcrudfastapi-production.up.railway.app/";
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  return dio;
});