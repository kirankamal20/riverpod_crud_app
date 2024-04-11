import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/delete_btn/controller/notifier/delete_btn_notifier.dart';
import 'package:riverpod_crud_app/features/delete_btn/view/ui_state/delete_btn_state.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteBtnView extends ConsumerWidget {
  final int studentId;
  final Function(String) onError;
  final Function(String) onSuccess;
  const DeleteBtnView(
      {required this.onError,
      required this.onSuccess,
      required this.studentId,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signOutBtnAsynData = ref.watch(deleteBtnAsyncNotifierPod(studentId));
    return signOutBtnAsynData.when(
      data: (data) => switch (data) {
        InitialDeleteButtonState() => IconButton(
            onPressed: () {
              ref
                  .read(deleteBtnAsyncNotifierPod(studentId).notifier)
                  .delete(onSuccess: onSuccess, onError: onError);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        DeleteButtonLoadingState() => IconButton(
            onPressed: () {},
            icon: const CircularProgressIndicator(
              color: Colors.white,
            ).h(20).w(20),
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
                  .read(deleteBtnAsyncNotifierPod(studentId).notifier)
                  .delete(onSuccess: onSuccess, onError: onError);
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
              .read(deleteBtnAsyncNotifierPod(studentId).notifier)
              .delete(onSuccess: onSuccess, onError: onError);
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
