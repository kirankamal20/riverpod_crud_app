import 'package:dio/dio.dart';
import 'package:riverpod_crud_app/data/const/api_urls.dart';

import 'i_authentication_provider.dart';

class AuthenticationProvider implements IAuthenticationProvider {
  final Dio dio;
  AuthenticationProvider({required this.dio});
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
    return await dio.get(ApiUrls.getAllstudents,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjI3LCJzY29wZSI6ImFjY2Vzc190b2tlbiIsImV4cCI6MTcwMzQ0ODM1MH0.GRgt31kNc1NdTciOi0JXVUNpaWF2aiYup_P6iqzE1U0"
        }));
  }
}
