import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/data/service/theme_service/i_theme_service_service.dart';
import 'package:riverpod_crud_app/data/service/theme_service/theme_service_service.dart';

final themeServicePod = Provider<IThemeService>((ref) {
  return ThemeService();
});
