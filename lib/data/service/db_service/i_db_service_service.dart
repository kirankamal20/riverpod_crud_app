import 'package:multiple_result/multiple_result.dart';

abstract class IDbServiceService {
  Future<void> setToken({required String token});
  Future<Result<String, Exception>> getToken();
  Future<Result<bool, Exception>> isUserAvailable();
  Future<void> removeToken();
}
