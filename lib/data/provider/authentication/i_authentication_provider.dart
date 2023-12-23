import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IAuthenticationProvider {
  Future<Response> login({required String email, required String password});
}
