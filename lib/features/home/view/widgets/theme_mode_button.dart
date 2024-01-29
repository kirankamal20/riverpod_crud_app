import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/core/theme/theme_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ThemeModeButton extends ConsumerWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themecontrollerProvider);
    return  
    
     IconButton(
        onPressed: () {
          ref.read(themecontrollerProvider.notifier).changeTheme(
              themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
        },
        icon: Icon(
            themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
        color: themeMode == ThemeMode.light ? Colors.black : Colors.white);
  }
}
