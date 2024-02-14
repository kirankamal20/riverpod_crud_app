import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/repository/authentication/authentication_repository_pod.dart';

class SearchNotifier extends AutoDisposeAsyncNotifier<List<Getallstudents>> {
  @override
  build() {
    return [];
  }

  void search({required String searchQuery}) async {
    state = const AsyncLoading(); 
    print("called");
    final result = await ref
        .watch(authenticationRepositoryPod)
        .searchStudent(searchQuery: searchQuery);

    result.when((success) {
      state = AsyncData(success);
    }, (error) {
      state = AsyncError(error.message, StackTrace.current);
    });
  }
}

final searchNotifierPod =
    AutoDisposeAsyncNotifierProvider<SearchNotifier, List<Getallstudents>>(
        SearchNotifier.new);
