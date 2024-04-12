// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:multiple_result/src/result.dart';

import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/provider/authentication/i_authentication_provider.dart';
import 'package:riverpod_crud_app/data/service/db_service/i_db_service_service.dart';

import 'i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationProvider iAuthenticationProvider;
  final IDbServiceService iDbServiceService;
  AuthenticationRepository({
    required this.iAuthenticationProvider,
    required this.iDbServiceService,
  });

  @override
  Future<Result<String, Exception>> login(
      {required String email, required String password}) async {
    final response =
        await iAuthenticationProvider.login(email: email, password: password);

    if (response.statusCode == 200) {
      return Success(response.data['detail']['token']);
    } else {
      return Error(Exception(response.data['detail']));
    }
  }

  @override
  Future<Result<List<Getallstudents>, AuthException>> getAllStudents() async {
    final response = await iAuthenticationProvider.getAllStudents();
    if (response.statusCode == 200) {
      var data = response.data as List;
      var result = data.map((e) => Getallstudents.fromMap(e)).toList();

      return Success(result);
    } else {
      return Error(AuthException(message: response.data['detail']));
    }
  }

  @override
  Future<Result<String, AuthException>> addStudnet(
      {required String filePath,
      required String studentName,
      required String studentAge,
      required String dateOfBirth,
      required String gender,
      required String country,
      required Function(int, int) onSendProgress}) async {
    final response = await iAuthenticationProvider.addStudnet(
        filePath: filePath,
        studentName: studentName,
        studentAge: studentAge,
        dateOfBirth: dateOfBirth,
        gender: gender,
        country: country,
        onSendProgress: onSendProgress);

    if (response.statusCode == 200) {
      return const Success("success");
    } else {
      return Error(AuthException(message: response.data.toString()));
    }
  }

  @override
  Future<Result<String, AuthException>> deleteStudent(
      {required int studentId}) async {
    final response =
        await iAuthenticationProvider.deleteStudent(studentId: studentId);

    if (response.statusCode == 200) {
      return Success(response.data['message']);
    } else {
      return Error(AuthException(message: response.data['detail']));
    }
  }

  @override
  Future<Result<String, AuthException>> updateStudent(
      {required String filePath,
      required int studentId,
      required String studentName,
      required String studentAge,
      required String dateOfBirth,
      required String gender,
      required String country,
      required Function(int, int) onSendProgress}) async {
    final response = await iAuthenticationProvider.updateStudent(
        filePath: filePath,
        studentName: studentName,
        studentAge: studentAge,
        dateOfBirth: dateOfBirth,
        gender: gender,
        country: country,
        studentId: studentId,
        onSendProgress: onSendProgress);

    if (response.statusCode == 200) {
      return Success(response.data['message']);
    } else {
      return Error(AuthException(message: response.data['detail']));
    }
  }

  @override
  Future<Result<List<Getallstudents>, AuthException>> searchStudent(
      {required String searchQuery}) async {
    final response =
        await iAuthenticationProvider.searchStudent(searchQuery: searchQuery);
    if (response.statusCode == 200) {
      var data = response.data as List;
      var result = data.map((e) => Getallstudents.fromMap(e)).toList();
      return Success(result);
    } else {
      return Error(AuthException(message: response.data['detail']));
    }
  }

  @override
  Future<Result<String, Exception>> register(
      {required String email, required String password}) async {
    final response = await iAuthenticationProvider.register(
        email: email, password: password);

    if (response.statusCode == 200) {
      return const Success("Successfully registered");
    } else {
      return Error(Exception(response.data['detail']));
    }
  }
}

class AuthException {
  final String message;
  AuthException({
    required this.message,
  });
}
