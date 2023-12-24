abstract class IThemeService {
  Future<void> setTheme({required String themeMode});
  Future<String> getTheme();
}
