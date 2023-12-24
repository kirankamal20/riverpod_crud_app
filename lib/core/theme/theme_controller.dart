import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/service/theme_service/theme_service_pod.dart';

final themecontrollerProvider =
    NotifierProvider.autoDispose<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
  name: 'themecontrollerProvider',
);

class ThemeModeController extends AutoDisposeNotifier<ThemeMode> {
  ThemeModeController() : super();

  @override
  ThemeMode build() {
    loadTheme();

    return ThemeMode.system;
  }

  Future<void> loadTheme() async {
    final themeService = ref.watch(themeServicePod);
    final theme = await themeService.getTheme();

    switch (theme) {
      case 'ThemeMode.dark':
        state = ThemeMode.dark;
        break;
      case 'ThemeMode.light':
        state = ThemeMode.light;
        break;
      default:
        state = ThemeMode.system;
    }
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    final themeService = ref.watch(themeServicePod);
    String themeString;
    state = themeMode;
    switch (themeMode) {
      case ThemeMode.dark:
        themeString = ThemeMode.dark.toString();
        break;
      case ThemeMode.light:
        themeString = ThemeMode.light.toString();
        break;
      default:
        themeString = ThemeMode.system.toString();
    }

    await themeService.setTheme(themeMode: themeString);
  }
}
