import 'package:multiple_result/multiple_result.dart';

abstract class IAuthenticationRepository {
  Future<Result<String, Exception>> login(
      {required String email, required String password});
}
