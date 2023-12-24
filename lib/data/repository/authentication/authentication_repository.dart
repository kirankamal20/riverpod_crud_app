import 'package:multiple_result/src/result.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
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

  @override
  Future<Result<List<Getallstudents>, Exception>> getAllStudents() async {
    final response = await iAuthenticationProvider.getAllStudents();
    if (response.statusCode == 200) {
      var b = response.data as List;
      var result = b.map((e) => Getallstudents.fromMap(e)).toList();

      return Success(result);
    } else {
      return Error(Exception("error"));
    }
  }
}
