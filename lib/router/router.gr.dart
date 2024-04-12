// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/cupertino.dart' as _i11;
import 'package:riverpod_crud_app/data/model/update_student_details_arg.dart'
    as _i10;
import 'package:riverpod_crud_app/features/add_student/view/add_student_page.dart'
    as _i1;
import 'package:riverpod_crud_app/features/home/view/home_page.dart' as _i2;
import 'package:riverpod_crud_app/features/login/view/login_page.dart' as _i3;
import 'package:riverpod_crud_app/features/mobile_login/view/mobile_login_page.dart'
    as _i4;
import 'package:riverpod_crud_app/features/mobile_otp_verify/view/mobile_otp_verify_page.dart'
    as _i5;
import 'package:riverpod_crud_app/features/register/view/register_page.dart'
    as _i6;
import 'package:riverpod_crud_app/features/search/view/search_page.dart' as _i7;
import 'package:riverpod_crud_app/features/splash_screen/view/splash_screen_page.dart'
    as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AddStudentRoute.name: (routeData) {
      final args = routeData.argsAs<AddStudentRouteArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddStudentPage(
          updateStudent: args.updateStudent,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    MobileLoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.MobileLoginPage(),
      );
    },
    MobileOtpVerifyRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MobileOtpVerifyPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SearchPage(),
      );
    },
    SplashRouteRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SplashScreenPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddStudentPage]
class AddStudentRoute extends _i9.PageRouteInfo<AddStudentRouteArgs> {
  AddStudentRoute({
    required _i10.UpdateStudent updateStudent,
    _i11.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          AddStudentRoute.name,
          args: AddStudentRouteArgs(
            updateStudent: updateStudent,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddStudentRoute';

  static const _i9.PageInfo<AddStudentRouteArgs> page =
      _i9.PageInfo<AddStudentRouteArgs>(name);
}

class AddStudentRouteArgs {
  const AddStudentRouteArgs({
    required this.updateStudent,
    this.key,
  });

  final _i10.UpdateStudent updateStudent;

  final _i11.Key? key;

  @override
  String toString() {
    return 'AddStudentRouteArgs{updateStudent: $updateStudent, key: $key}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.MobileLoginPage]
class MobileLoginRoute extends _i9.PageRouteInfo<void> {
  const MobileLoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MobileLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'MobileLoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MobileOtpVerifyPage]
class MobileOtpVerifyRoute extends _i9.PageRouteInfo<void> {
  const MobileOtpVerifyRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MobileOtpVerifyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MobileOtpVerifyRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SearchPage]
class SearchRoute extends _i9.PageRouteInfo<void> {
  const SearchRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SplashScreenPage]
class SplashRouteRoute extends _i9.PageRouteInfo<void> {
  const SplashRouteRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SplashRouteRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRouteRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
