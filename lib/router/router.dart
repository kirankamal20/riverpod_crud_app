// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';

import 'package:riverpod_crud_app/data/service/db_service/i_db_service_service.dart';
import 'package:riverpod_crud_app/router/guard/auth_guard.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final IDbServiceService iDbServiceService;
  AppRouter({
    required this.iDbServiceService,
  });
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          path: "/ ",
          initial: true,
          guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: "/HomeRoute ",
          // guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        ),
        AutoRoute(
          page: AddStudentRoute.page,
          path: "/AddStudentRoute ",
          // guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        )
      ];
}
