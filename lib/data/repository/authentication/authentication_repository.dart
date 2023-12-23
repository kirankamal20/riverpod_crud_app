import 'package:multiple_result/src/result.dart';
import 'package:riverpod_crud_app/data/provider/authentication/i_authentication_provider.dart';

import 'i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationProvider iAuthenticationProvider;
  AuthenticationRepository({required this.iAuthenticationProvider});

  @override
  Future<Result<String, Exception>> login(
      {required String email, required String password}) async {
    final response =
        await iAuthenticationProvider.login(email: email, password: password);

    if (response.statusCode == 200) {
      return const Success("success");
    } else {
      return Error(Exception("error"));
    }
  }
}
