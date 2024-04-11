import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/model/add_student_model.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/main.dart';

final offlineGetallStudentPod =
    FutureProvider.autoDispose<List<AddStudentModel>>((ref) async {
  final offlineGetallStudents = await ref.watch(dbServicePod).getAllStudents();

  return offlineGetallStudents.when((allStudentsDetails) {
    return allStudentsDetails;
    // talker.good(allStudentsDetails);
    // if (allStudentsDetails.isNotEmpty) {
    //   return true;
    // } else {
    //   return false;
    // }
  }, (error) {
    throw error;
  });
});
