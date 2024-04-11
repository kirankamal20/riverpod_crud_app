import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/features/home/controller/get_all_students_pod.dart';
import 'package:riverpod_crud_app/main.dart';
import 'package:riverpod_crud_app/shared/pod/internet_checker_pod.dart';

class HomePageAsyncNotifier
    extends AutoDisposeAsyncNotifier<List<Getallstudents>> {
  @override
  build() {
    getAllStudents();
    return future;
  }

  void getAllStudents() async {
    final internetChecker = await ref.watch(internetCheckerPod.future);
    if (internetChecker == InternetConnectionStatus.connected) {
      final onlineGetallStudents = await ref.watch(getllStudentsPod.future);

      state = AsyncData(onlineGetallStudents);
    } else {
      final offlineGetallStudents =
          await ref.watch(dbServicePod).getAllStudents();

      offlineGetallStudents.when((success) {
        var students = <Getallstudents>[];
        for (var e in success) {
          students.add(
            Getallstudents(
                student_age: e.studentAge,
                id: 2,
                country: e.country,
                image: e.imageFilePath,
                date_of_birth: e.dateOfBirth,
                student_name: e.studentName,
                gender: e.gender,
                owner_id: 1),
          );
        }
        state = AsyncData(students);
        talker.error(students);
      }, (error) {
        state = AsyncError(error, StackTrace.current);
      });
    }
  }
}
