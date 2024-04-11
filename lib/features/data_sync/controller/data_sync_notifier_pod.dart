import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/data_sync/controller/notifier/data_sync_notifier.dart';
import 'package:riverpod_crud_app/features/data_sync/view/ui_state/data_sync_state.dart';

final dataSyncNotifierPod = AsyncNotifierProvider.autoDispose<
    DataSyncAsyncNotifier, DataSyncButtonState>(
  () => DataSyncAsyncNotifier(),
);
