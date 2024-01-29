import 'package:flutter/material.dart';

class Themes {
  Themes._();

  static ThemeData get lighttheme =>
      ThemeData.light(useMaterial3: true).copyWith(
        // primaryColor: const Color.fromARGB(255, 3, 3, 77),
        scaffoldBackgroundColor: Colors.grey.shade100,
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.dark,
        //   onSecondaryContainer: Colors.red,
        //   primary: Colors.blue,
        //   onPrimary: Colors.white,
        //   secondary: Colors.green,
        //   onSecondary: Colors.white,
        //   primaryContainer: Colors.red,
        //   error: Colors.black,
        //   onError: Colors.white,
        //   background: Colors.blue,
        //   onBackground: Colors.white,
        //   surface: Colors.pink,
        //   onSurface: Colors.white,
        //   tertiaryContainer: Colors.white,
        // ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color.fromARGB(255, 3, 3, 77),
            ),
          ),
        ),
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Color.fromARGB(255, 3, 3, 77),
        // ),
      );

  static ThemeData get darkTheme => ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff2f2f2f),
        ),
      );
}
