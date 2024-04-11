import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/data_sync/controller/data_sync_check_pod.dart';
import 'package:riverpod_crud_app/features/data_sync/controller/data_sync_notifier_pod.dart';
import 'package:riverpod_crud_app/features/data_sync/view/ui_state/data_sync_state.dart';
import 'package:riverpod_crud_app/main.dart';
import 'package:velocity_x/velocity_x.dart';

class DataSyncButton extends ConsumerWidget {
  const DataSyncButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDataAvailable = ref.watch(offlineGetallStudentPod);
    return isDataAvailable.when(
      data: (data) => data.isNotEmpty
          ? Consumer(
              builder: (_, WidgetRef ref, __) {
                final dataSyncAsync = ref.watch(dataSyncNotifierPod);
                return dataSyncAsync.when(
                  data: (data) {
                    return switch (data) {
                      InitialDataSyncButtonState() => IconButton(
                          onPressed: () {
                            ref.read(dataSyncNotifierPod.notifier).syncData();
                          },
                          icon: const Icon(Icons.sync)),
                      DataSyncButtonLoadingState() => IconButton(
                          onPressed: null,
                          icon: const CircularProgressIndicator().h(20).w(20)),
                      DataSyncButtonSuccessState() => const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                          )),
                      DataSyncButtonErrorState() => IconButton(
                          onPressed: () {
                            ref.read(dataSyncNotifierPod.notifier).syncData();
                          },
                          icon: const Icon(Icons.error))
                    };
                  },
                  error: (error, stackTrace) => IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.error,
                        color: Colors.red,
                      )),
                  loading: () => IconButton(
                      onPressed: () {},
                      icon: const CircularProgressIndicator().h(20).w(20)),
                );
              },
            )
          : const SizedBox.shrink(),
      error: (error, stackTrace) {
        talker.error(error);
        return const SizedBox.shrink();
      },
      loading: () => const Icon(
        Icons.sync,
      ),
    );
  }
}
