import 'package:flutter/material.dart';

class Themes {
  Themes._();

  static ThemeData get lighttheme =>
      ThemeData.light(useMaterial3: true).copyWith(
          primaryColor: const Color.fromARGB(255, 3, 3, 77),
          scaffoldBackgroundColor: Colors.white,
          // colorScheme: const ColorScheme(
          //   brightness: Brightness.dark,
          //   onSecondaryContainer: Colors.red,
          //   primary: Colors.blue,
          //   onPrimary: Colors.white,
          //   secondary: Colors.green,
          //   onSecondary: Colors.white,
          //   primaryContainer: Colors.green,
          //   error: Colors.black,
          //   onError: Colors.white,
          //   background: Colors.blue,
          //   onBackground: Colors.white,
          //   surface: Colors.green,
          //   onSurface: Colors.white,
          //   tertiaryContainer: Colors.white,
          // ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 3, 3, 77),
          ),
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 3, 3, 77),
              ),
              textStyle: MaterialStatePropertyAll(
                TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          dialogBackgroundColor: Colors.white,
          dialogTheme: const DialogTheme(backgroundColor: Colors.white)
          // appBarTheme: const AppBarTheme(
          //   backgroundColor: Color.fromARGB(255, 3, 3, 77),
          // ),
          );

  static ThemeData get darkTheme => ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff2f2f2f),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(
              Colors.black,
            ),
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
      );
}
