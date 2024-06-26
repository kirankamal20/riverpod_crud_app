import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riverpod_crud_app/core/theme/app_theme.dart';
import 'package:riverpod_crud_app/core/theme/theme_controller.dart';
import 'package:riverpod_crud_app/l10n/l10n.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/shared/helpers/no_internet_widget.dart';
import 'package:riverpod_crud_app/shared/pod/locale_pod.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(autorouterprovider);
    final themeMode = ref.watch(themecontrollerProvider);
    final locale = ref.watch(localePod);
    return MaterialApp.router(
      routerConfig: router.config(),
      theme: Themes.lighttheme,
      darkTheme: Themes.darkTheme,
      themeMode: themeMode,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      locale: locale,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: Builder(
            builder: (context) {
              return ResponsiveScaledBox(
                width: ResponsiveValue<double>(
                  context,
                  conditionalValues: [
                    Condition.equals(name: MOBILE, value: 450),
                    // Condition.between(start: 800, end: 1100, value: 800),
                    // Condition.between(start: 1000, end: 1200, value: 700),
                  ],
                ).value,
                child: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarBrightness: Brightness.dark,
                  ),
                  child: GestureDetector(
                    child: InternetCheckerWidget(widget, child: child!),
                    onTap: () {},
                  ),
                ),
              );
            },
          ),
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
    );
  }
}
