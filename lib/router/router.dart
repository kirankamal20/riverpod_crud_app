// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';

import 'package:riverpod_crud_app/data/service/db_service/i_db_service_service.dart';
import 'package:riverpod_crud_app/router/guard/auth_guard.dart';
import 'package:riverpod_crud_app/router/guard/splash_guard.dart';
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
          page: SplashRouteRoute.page,
          path: "/",
          initial: true,
          guards: [SplashGuard(iDbServiceService: iDbServiceService)],
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: "/LoginRoute ",
          guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        ),
        CustomRoute(
          page: HomeRoute.page,
          path: "/HomeRoute ",
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
        ),
        AutoRoute(
          page: AddStudentRoute.page,
          path: "/AddStudentRoute ",
          // guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        ),
        AutoRoute(
          page: SearchRoute.page,
          path: "/SearchRoute ",
          // guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        ),
        AutoRoute(
          page: RegisterRoute.page,
          path: "/RegisterRoute ",
          // guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        ),
        AutoRoute(
          page: MobileLoginRoute.page,
          path: "/MobileLoginRoute ",
          // guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        ),
        AutoRoute(
          page: MobileOtpVerifyRoute.page,
          path: "/MobileOtpVerifyRoute ",
          // guards: [AuthGuard(iDbServiceService: iDbServiceService)],
        )
      ];
}
