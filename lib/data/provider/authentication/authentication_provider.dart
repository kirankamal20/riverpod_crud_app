import 'package:dio/dio.dart';
import 'package:riverpod_crud_app/data/const/api_urls.dart';
import 'package:riverpod_crud_app/data/service/db_service/i_db_service_service.dart';

import 'i_authentication_provider.dart';

class AuthenticationProvider implements IAuthenticationProvider {
  final Dio dio;
  final IDbServiceService iDbServiceService;
  AuthenticationProvider({required this.iDbServiceService, required this.dio});
  @override
  Future<Response> login(
      {required String email, required String password}) async {
    return await dio.post(
      ApiUrls.loginapi,
      data: {"email": email, "password": password},
    );
  }

  @override
  Future<Response> getAllStudents() async {
    final result = await iDbServiceService.getToken();
    final token = result.tryGetSuccess();
    return await dio.get(ApiUrls.getAllstudents,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }));
  }

  @override
  Future<Response> deleteStudent({required int studentId}) async {
    final result = await iDbServiceService.getToken();
    final token = result.tryGetSuccess();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    return await dio.delete(
      "${ApiUrls.deleteStudent}$studentId",
      options: Options(
        headers: headers,
      ),
    );
  }

  @override
  Future<Response> updateStudent(
      {required String filePath,
      required int studentId,
      required String studentName,
      required String studentAge,
      required String dateOfBirth,
      required String gender,
      required String country,
      required Function(int, int) onSendProgress}) async {
    final result = await iDbServiceService.getToken();
    final token = result.tryGetSuccess();
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var data = FormData.fromMap({
      'image': [
        await MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last),
      ],
      'student_id': studentId.toString(),
      'student_name': studentName,
      'student_age': studentAge,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'country': country,
    });

    return await dio.put(ApiUrls.updateStudent,
        options: Options(
          headers: headers,
        ),
        data: data,
        onSendProgress: onSendProgress);
  }

  @override
  Future<Response> addStudnet(
      {required String filePath,
      required String studentName,
      required String studentAge,
      required String dateOfBirth,
      required String gender,
      required String country,
      required Function(int, int) onSendProgress}) async {
    final result = await iDbServiceService.getToken();
    final token = result.tryGetSuccess();
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var data = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath,
          filename: filePath.split('/').last),
      'student_name': studentName,
      'student_age': studentAge,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'country': country
    });

    return await dio.request(ApiUrls.addStudent,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
        onSendProgress: onSendProgress);
  }

  @override
  Future<Response> searchStudent({required String searchQuery}) async {
    final result = await iDbServiceService.getToken();
    final token = result.tryGetSuccess();

    return await dio.post("${ApiUrls.searchStudent}$searchQuery",
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }));
  }

  @override
  Future<Response> register(
      {required String email, required String password}) async {
    return await dio.post(
      ApiUrls.register,
      data: {"email": email, "password": password},
    );
  }
}
