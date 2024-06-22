import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(

      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color.fromRGBO(20, 154, 255, 1.0),
      ),

      scaffoldBackgroundColor: const Color.fromRGBO(210, 233, 245, 1.0),
      primaryColor: const Color.fromRGBO(6, 147, 253, 1),
      splashColor: Colors.black26,
      fontFamily: 'IBM',

      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(6, 135, 232, 1.0),
        secondary: Colors.red,
        brightness: Brightness.light,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(6, 135, 232, 1.0),
        selectedItemColor: Color.fromRGBO(33, 160, 255, 1.0),
        selectedLabelStyle: TextStyle(color: Colors.black),
      )

    );
  } static ThemeData get dark {
    return ThemeData(

      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Color.fromRGBO(4, 107, 185, 1.0),
      ),

      scaffoldBackgroundColor: const Color.fromRGBO(4, 107, 185, 1.0),
      primaryColor: Colors.grey,
      splashColor: Colors.transparent,
      fontFamily: 'IBM',

      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(15, 109, 187, 1.0),
        secondary: Colors.red,
        brightness: Brightness.dark,
      ),

    );
  }
}
