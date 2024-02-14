import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository.dart';

abstract class IAuthenticationRepository {
  Future<Result<String, Exception>> login(
      {required String email, required String password});
  Future<Result<List<Getallstudents>, AuthException>> getAllStudents();
  Future<Result<String, AuthException>> addStudnet(
      {required String filePath,
      required String studentName,
      required String studentAge,
      required String dateOfBirth,
      required String gender,
      required String country,
      required Function(int, int) onSendProgress});
  Future<Result<String, AuthException>> updateStudent(
      {required String filePath,
      required int studentId,
      required String studentName,
      required String studentAge,
      required String dateOfBirth,
      required String gender,
      required String country,
      required Function(int, int) onSendProgress});
  Future<Result<String, AuthException>> deleteStudent({required int studentId});
  Future<Result<List<Getallstudents>, AuthException>> searchStudent({required String searchQuery});
}
