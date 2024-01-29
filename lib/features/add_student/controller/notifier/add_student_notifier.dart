import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository_pod.dart';
import 'package:riverpod_crud_app/features/add_student/view/ui_state/add_student_notifier_sate.dart';

class AddStudentNotifier extends AutoDisposeAsyncNotifier<AddStudentState> {
  @override
  FutureOr<AddStudentState> build() {
    return const InitialAddStudentState();
  }

  void addStudent({
    required String filePath,
    required String studentName,
    required String studentAge,
    required String dateOfBirth,
    required String gender,
    required String country,
    required Function onSuccess,
    required Function(String errorMessage) onError,
  }) async {
    state = const AsyncData(LoadingAddStudentState(percentage: 0));
    final result = await ref.watch(authenticationRepositoryPod).addStudnet(
          filePath: filePath,
          studentName: studentName,
          studentAge: studentAge,
          dateOfBirth: dateOfBirth,
          gender: gender,
          country: country,
          onSendProgress: (int sent, int total) {
            double progressPercentage = (sent / total) * 100;
            print('Upload progress: ${progressPercentage.round()}%');

            state = AsyncData(LoadingAddStudentState(
                percentage: progressPercentage.round().toInt()));
          },
        );

    result.when((success) {
      state = const AsyncData(AddStudentStateSuccessState());
      onSuccess();
    }, (error) {
      onError(error.message);
      state = const AsyncData(AddStudentStateErrorState());
    });
  }

  void updateStudent({
    required String filePath,
    required String studentName,
    required String studentAge,
    required String dateOfBirth,
    required String gender,
    required String country,
    required Function onSuccess,
    required int studentId,
    required Function(String errorMessage) onError,
  }) async {
    state = const AsyncData(LoadingAddStudentState(percentage: 0));
    final result = await ref.watch(authenticationRepositoryPod).updateStudent(
          studentId: studentId,
          filePath: filePath,
          studentName: studentName,
          studentAge: studentAge,
          dateOfBirth: dateOfBirth,
          gender: gender,
          country: country,
          onSendProgress: (int sent, int total) {
            double progressPercentage = (sent / total) * 100;
            print('Upload progress: ${progressPercentage.round()}%');

            state = AsyncData(LoadingAddStudentState(
                percentage: progressPercentage.round().toInt()));
          },
        );

    result.when((success) {
      state = const AsyncData(AddStudentStateSuccessState());
      onSuccess();
    }, (error) {
      onError(error.message);
      state = const AsyncData(AddStudentStateErrorState());
    });
  }
}

final addStudentNotifierPod =
    AsyncNotifierProvider.autoDispose<AddStudentNotifier, AddStudentState>(
        AddStudentNotifier.new);
