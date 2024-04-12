import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/features/delete_btn/controller/notifier/delete_btn_notifier.dart';
import 'package:riverpod_crud_app/features/delete_btn/view/ui_state/delete_btn_state.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteBtnView extends ConsumerWidget {
  final Getallstudents getallstudents;
  final Function(String) onError;
  final Function(String) onSuccess;
  const DeleteBtnView(
      {required this.getallstudents,
      required this.onError,
      required this.onSuccess,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signOutBtnAsynData =
        ref.watch(deleteBtnAsyncNotifierPod(getallstudents));
    return signOutBtnAsynData.when(
      data: (data) => switch (data) {
        InitialDeleteButtonState() => IconButton(
            onPressed: () {
              ref
                  .read(deleteBtnAsyncNotifierPod(getallstudents).notifier)
                  .deleteStudent(onSuccess: onSuccess, onError: onError);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        DeleteButtonLoadingState() => IconButton(
            onPressed: () {},
            icon: LoadingAnimationWidget.dotsTriangle(
              color: Colors.red,
              size: 30,
            ),
          ),
        DeleteButtonSuccessState() => IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        DeleteButtonErrorState() => IconButton(
            onPressed: () {
              ref
                  .read(deleteBtnAsyncNotifierPod(getallstudents).notifier)
                  .deleteStudent(onSuccess: onSuccess, onError: onError);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
      },
      error: (error, stackTrace) => IconButton(
        onPressed: () {
          ref
              .read(deleteBtnAsyncNotifierPod(getallstudents).notifier)
              .deleteStudent(onSuccess: onSuccess, onError: onError);
        },
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
      loading: () => IconButton(
        onPressed: () {},
        icon: const CircularProgressIndicator(
          color: Colors.white,
        ).h(20).w(20),
      ),
    );
  }
}
