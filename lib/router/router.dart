import 'package:auto_route/auto_route.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          path: "/LoginRoute",
        ),
        AutoRoute(page: HomeRoute.page, path: "/ ", initial: true)
      ];
}
