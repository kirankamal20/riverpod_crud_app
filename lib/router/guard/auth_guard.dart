// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';

import 'package:riverpod_crud_app/data/service/db_service/i_db_service_service.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final IDbServiceService iDbServiceService;
  AuthGuard({
    required this.iDbServiceService,
  });
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final result = await iDbServiceService.isUserAvailable();
    result.when((success) {
      print("route executed");
      router.replace(const HomeRoute());
    }, (error) {
      resolver.next();
    });
  }
}
