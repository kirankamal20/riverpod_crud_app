import 'package:flutter/material.dart';

class Themes {
  Themes._();

  static ThemeData get lighttheme =>
      ThemeData.light(useMaterial3: true).copyWith(
        primaryColor: const Color.fromARGB(255, 3, 3, 77),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color.fromARGB(255, 3, 3, 77),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 3, 3, 77),
        ),
      );

  static ThemeData get darkTheme => ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff2f2f2f),
        ),
      );
}
