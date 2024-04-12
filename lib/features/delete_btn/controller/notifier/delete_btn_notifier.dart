import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository_pod.dart';
import 'package:riverpod_crud_app/data/service/db_service/db_service_pod.dart';
import 'package:riverpod_crud_app/features/delete_btn/view/ui_state/delete_btn_state.dart';
import 'package:riverpod_crud_app/features/home/controller/get_all_students_pod.dart';
import 'package:riverpod_crud_app/features/home/controller/home_page_notifier_pod.dart';
import 'package:riverpod_crud_app/shared/pod/internet_checker_pod.dart';

class DeleteButtonNotifier
    extends AutoDisposeFamilyAsyncNotifier<DeleteButtonState, Getallstudents> {
  @override
  FutureOr<DeleteButtonState> build(arg) {
    return InitialDeleteButtonState();
  }

  void deleteStudent(
      {required Function(String) onSuccess,
      required Function(String) onError}) async {
    final internetChecker = await ref.watch(internetCheckerPod.future);
    if (internetChecker == InternetConnectionStatus.connected) {
      state = AsyncData(DeleteButtonLoadingState());
      var result = await ref
          .read(authenticationRepositoryPod)
          .deleteStudent(studentId: arg.id);

      result.when((success) {
        ref.invalidate(getllStudentsPod);
        onSuccess(success);

        state = AsyncData(DeleteButtonSuccessState());
      }, (error) {
        onError(error.message);
        state = AsyncData(DeleteButtonErrorState(error.message));
      });
    } else {
      state = AsyncData(DeleteButtonLoadingState());
      final result =
          await ref.watch(dbServicePod).deleteStudent(studentId: arg.studentId);
      result.when((success) {
        ref.invalidate(getallStudentsNotifier);
        state = AsyncData(DeleteButtonSuccessState());
      }, (error) {
        state = AsyncData(DeleteButtonErrorState(error.toString()));
      });
    }
  }
}

final deleteBtnAsyncNotifierPod = AutoDisposeAsyncNotifierProvider.family<
    DeleteButtonNotifier,
    DeleteButtonState,
    Getallstudents>(DeleteButtonNotifier.new);
