import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository_pod.dart';
import 'package:riverpod_crud_app/features/delete_btn/view/ui_state/delete_btn_state.dart';
import 'package:riverpod_crud_app/features/home/controller/get_all_students_pod.dart';

class DeleteButtonNotifier
    extends AutoDisposeFamilyAsyncNotifier<DeleteButtonState, int> {
  @override
  FutureOr<DeleteButtonState> build(arg) {
    return InitialDeleteButtonState();
  }

  void delete(
      {required Function(String) onSuccess,
      required Function(String) onError}) async {
    state = AsyncData(DeleteButtonLoadingState());
    var result = await ref
        .read(authenticationRepositoryPod)
        .deleteStudent(studentId: arg);

    result.when((success) {
      ref.invalidate(getllStudentsPod);
      onSuccess(success);

      state = AsyncData(DeleteButtonSuccessState());
    }, (error) {
      onError(error.message);
      state = AsyncData(DeleteButtonErrorState(error.message));
    });
  }
}

final deleteBtnAsyncNotifierPod = AutoDisposeAsyncNotifierProvider.family<
    DeleteButtonNotifier, DeleteButtonState, int>(DeleteButtonNotifier.new);
