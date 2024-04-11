import 'package:dio/dio.dart';

abstract class IAuthenticationProvider {
  Future<Response> login({required String email, required String password});
  Future<Response> register({required String email, required String password});
  Future<Response> getAllStudents();
  Future<Response> addStudnet(
      {required String filePath,
      required String studentName,
      required String studentAge,
      required String dateOfBirth,
      required String gender,
      required String country,
    required  Function(int, int) onSendProgress});
  Future<Response> updateStudent({
    required String filePath,
    required int studentId,
    required String studentName,
    required String studentAge,
    required String dateOfBirth,
    required String gender,
    required String country, required  Function(int, int) onSendProgress
  });
  Future<Response> deleteStudent({required int studentId});
  Future<Response> searchStudent({required String searchQuery} );
}
