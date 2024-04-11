// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_crud_app/data/model/add_student_model.dart';
import 'package:riverpod_crud_app/main.dart';
import 'package:uuid/uuid.dart';
import 'i_db_service_service.dart';

class DbServiceService implements IDbServiceService {
  final Box userBox;
  DbServiceService({
    required this.userBox,
  });
  @override
  Future<Result<String, Exception>> getToken() async {
    try {
      final result = await userBox.get("token");
      if (result != null) {
        talker.good("token $result");
        return Success(result);
      } else {
        return Error(Exception("token Not Found"));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }

  @override
  Future<void> setToken({required String token}) async {
    await userBox.put("token", token);
  }

  @override
  Future<Result<bool, Exception>> isUserAvailable() async {
    final result = await getToken();

    return result.when((success) => const Success(true),
        (error) => Error(Exception("User Not Available")));
  }

  @override
  Future<void> removeToken() async {
    await userBox.delete("token");
  }

  @override
  Future<Result<List<AddStudentModel>, Exception>> getAllStudents() async {
    try {
      List<AddStudentModel> listStudents = [];
      var students = await Hive.openBox('students');

      // final result = await userBox.get("student");
      // if (result != null) {
      //   talker.good("result $result");
      var dataLength = students.values.toList();

      if (dataLength.isNotEmpty) {
        talker.log(dataLength.toString());
        talker.log(dataLength.length.toString());
        for (int i = 0; i < dataLength.length; i++) {
          var allstudents = students.getAt(i);
          var data2 = AddStudentModel.fromJson(allstudents);
          listStudents.add(data2);
          talker.log(listStudents);
        }
        return Success(listStudents);
      } else {
        return Error(Exception("Student not found"));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }

  @override
  Future<Result<AddStudentModel, Exception>> syncStudents() async {
    try {
      final result = await userBox.get("student");
      if (result != null) {
        talker.good("result $result");
        return Success(result);
      } else {
        return Error(Exception("token Not Found"));
      }
    } catch (e) {
      return Error(Exception(e));
    }
  }

  @override
  Future<Result<bool, Exception>> addStudent(
      {required AddStudentModel addStudentModel}) async {
    try {
      var students = await Hive.openBox('students');
      students.put(addStudentModel.studentId, addStudentModel.toJson());
      // await userBox.put(uuid.v1(), addStudentModel.toJson());
      return const Success(true);
    } catch (e) {
      return Error(Exception(e));
    }
  }

  @override
  Future<Result<bool, Exception>> deleteStudent(
      {required String studentId}) async {
    try {
      var students = await Hive.openBox('students');
      students.delete(studentId);
      return const Success(true);
    } catch (e) {
      return Error(Exception(e));
    }
  }
}
