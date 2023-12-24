import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository_pod.dart';

final getllStudentsPod =
    FutureProvider.autoDispose<List<Getallstudents>>((ref) async {
  final result = await ref.watch(authenticationRepositoryPod).getAllStudents();
  return result.when((success) {
    return success;
  }, (error) {
    throw error.toString();
  });
});
