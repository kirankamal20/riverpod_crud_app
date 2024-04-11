import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_crud_app/data/model/add_student_model.dart';

abstract class IDbServiceService {
  Future<void> setToken({required String token});
  Future<Result<String, Exception>> getToken();
  Future<Result<bool, Exception>> isUserAvailable();
  Future<void> removeToken();

  Future<Result<bool, Exception>> addStudent(
      {required AddStudentModel addStudentModel});
  Future<Result<AddStudentModel, Exception>> syncStudents();
  Future<Result<List<AddStudentModel>, Exception>> getAllStudents();
  Future<Result<bool, Exception>> deleteStudent({required String studentId});
}
