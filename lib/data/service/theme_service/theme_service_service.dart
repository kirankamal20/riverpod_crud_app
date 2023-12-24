import 'package:hive_flutter/hive_flutter.dart';

import 'package:riverpod_crud_app/data/service/theme_service/i_theme_service_service.dart';

class ThemeService implements IThemeService {
  static String boxName = 'themeBox';
  static String themeKey = 'themeKey';

  @override
  Future<String> getTheme() async {
    final box = await Hive.openBox(boxName);
    final theme = box.get(themeKey);
    if (theme != null) {
      return theme;
    }
    return "";
  }

  @override
  Future<void> setTheme({required String themeMode}) async {
    final box = await Hive.openBox(boxName);
    await box.put(themeKey, themeMode);
  }
}
