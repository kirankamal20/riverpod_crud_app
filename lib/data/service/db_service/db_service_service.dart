// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_crud_app/main.dart';

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
}
