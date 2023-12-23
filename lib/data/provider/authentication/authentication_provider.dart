import 'package:dio/dio.dart';
import 'package:riverpod_crud_app/data/const/api_urls.dart';

import 'i_authentication_provider.dart';

class AuthenticationProvider implements IAuthenticationProvider {
  final Dio dio;
  AuthenticationProvider({required this.dio});
  @override
  Future<Response> login({required String email,required String password}) async {
    return await dio.post(
      ApiUrls.loginapi,
      data: {"email": email, "password": password},
    );
  }
}
