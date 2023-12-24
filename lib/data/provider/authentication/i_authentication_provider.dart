import 'package:dio/dio.dart';

abstract class IAuthenticationProvider {
  Future<Response> login({required String email, required String password});
  Future<Response> getAllStudents();
}
