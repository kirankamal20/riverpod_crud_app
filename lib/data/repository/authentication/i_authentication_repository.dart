import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';

abstract class IAuthenticationRepository {
  Future<Result<String, Exception>> login(
      {required String email, required String password});
  Future<Result<List<Getallstudents>, Exception>> getAllStudents();
}
