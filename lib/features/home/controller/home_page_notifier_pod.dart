import 'package:riverpod/riverpod.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/features/home/controller/notifier/home_notifier.dart';

final getallStudentsNotifier = AsyncNotifierProvider.autoDispose<
    HomePageAsyncNotifier, List<Getallstudents>>(
  () => HomePageAsyncNotifier(),
);
