import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository_pod.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/features/data_sync/controller/data_sync_check_pod.dart';
import 'package:riverpod_crud_app/features/data_sync/view/ui_state/data_sync_state.dart';
import 'package:riverpod_crud_app/features/home/controller/home_page_notifier_pod.dart';

class DataSyncAsyncNotifier
    extends AutoDisposeAsyncNotifier<DataSyncButtonState> {
  @override
  FutureOr<DataSyncButtonState> build() {
    return InitialDataSyncButtonState();
  }

  void syncData(
      {required Function onSuccess,
      required Function(String errorMessage) onError}) async {
    state = AsyncData(DataSyncButtonLoadingState());
    final getAllStudents = await ref.watch(offlineGetallStudentPod.future);

    int successfulUploads = 0;
    int totalStudents = getAllStudents.length;

    for (var element in getAllStudents) {
      final result = await ref.watch(authenticationRepositoryPod).addStudnet(
            filePath: element.imageFilePath,
            studentName: element.studentName,
            studentAge: element.studentAge,
            dateOfBirth: element.dateOfBirth,
            gender: element.gender,
            country: element.country,
            onSendProgress: (int sent, int total) {
              double progressPercentage = (sent / total) * 100;
              print('Upload progress: ${progressPercentage.round()}%');
            },
          );

      result.when((success) async {
        successfulUploads++;
        await ref
            .watch(dbServicePod)
            .deleteStudent(studentId: element.studentId);
        if (successfulUploads == totalStudents) {
          state = AsyncData(DataSyncButtonSuccessState());
          onSuccess();
          ref.invalidate(getallStudentsNotifier);
        }
      }, (error) {
        onError(error.message);
        state = AsyncData(DataSyncButtonErrorState(error.message));
      });
    }
  }
}
