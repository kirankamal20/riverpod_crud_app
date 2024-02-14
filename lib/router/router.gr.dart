// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/cupertino.dart' as _i7;
import 'package:riverpod_crud_app/data/model/update_student_details_arg.dart'
    as _i6;
import 'package:riverpod_crud_app/features/add_student/view/add_student_page.dart'
    as _i1;
import 'package:riverpod_crud_app/features/home/view/home_page.dart' as _i2;
import 'package:riverpod_crud_app/features/login/view/login_page.dart' as _i3;
import 'package:riverpod_crud_app/features/search/view/search_page.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AddStudentRoute.name: (routeData) {
      final args = routeData.argsAs<AddStudentRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddStudentPage(
          updateStudent: args.updateStudent,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SearchPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddStudentPage]
class AddStudentRoute extends _i5.PageRouteInfo<AddStudentRouteArgs> {
  AddStudentRoute({
    required _i6.UpdateStudent updateStudent,
    _i7.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          AddStudentRoute.name,
          args: AddStudentRouteArgs(
            updateStudent: updateStudent,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddStudentRoute';

  static const _i5.PageInfo<AddStudentRouteArgs> page =
      _i5.PageInfo<AddStudentRouteArgs>(name);
}

class AddStudentRouteArgs {
  const AddStudentRouteArgs({
    required this.updateStudent,
    this.key,
  });

  final _i6.UpdateStudent updateStudent;

  final _i7.Key? key;

  @override
  String toString() {
    return 'AddStudentRouteArgs{updateStudent: $updateStudent, key: $key}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SearchPage]
class SearchRoute extends _i5.PageRouteInfo<void> {
  const SearchRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
