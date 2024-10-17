import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(

      fontFamily: 'IBM',

      primaryColor: const Color.fromRGBO(6, 147, 253, 1),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color.fromRGBO(20, 154, 255, 1.0),
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromRGBO(242, 248, 255, 1.0),
        surfaceTintColor: Colors.red,
        shadowColor: Colors.black,
      ),

      scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),

      splashColor: Colors.black26,

      iconTheme: const IconThemeData(
        color: Color.fromRGBO(58, 58, 58, 1.0)
      ),

      textTheme: const TextTheme(
        headlineSmall: TextStyle(color: Color.fromRGBO(58, 58, 58, 1.0)),
        bodyLarge: TextStyle(color: Color.fromRGBO(58, 58, 58, 1.0))
      ),


      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(6, 135, 232, 1.0),
        secondary: Colors.red,
        tertiary: Colors.deepOrange,
        tertiaryContainer: Colors.white,
        outline: const Color.fromRGBO(192, 192, 192, 1.0),
        brightness: Brightness.light,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(6, 135, 232, 1.0),
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.black),
      ),

      listTileTheme: ListTileThemeData(
        tileColor: const Color.fromRGBO(242, 248, 255, 1.0),
        textColor: Colors.black,
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        subtitleTextStyle: const TextStyle(fontStyle: FontStyle.italic),
        iconColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.5)
        ),
      ),

    );
  } static ThemeData get dark {
    return ThemeData(

      fontFamily: 'IBM',

      primaryColor: Colors.black,

      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Color.fromRGBO(4, 107, 185, 1.0),
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromRGBO(33, 160, 255, 1.0),
        surfaceTintColor: Colors.red,
      ),

      scaffoldBackgroundColor: Colors.black,

      splashColor: Colors.transparent,

      iconTheme: const IconThemeData(
          color: Color.fromRGBO(58, 58, 58, 1.0)
      ),

      textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Color.fromRGBO(58, 58, 58, 1.0)),
          bodyLarge: TextStyle(color: Color.fromRGBO(58, 58, 58, 1.0))
      ),


      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(6, 135, 232, 1.0),
        secondary: Colors.red,
        tertiary: Colors.deepOrange,
        tertiaryContainer: Colors.white,
        outline: const Color.fromRGBO(192, 192, 192, 1.0),
        brightness: Brightness.light,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.red
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(6, 135, 232, 1.0),
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.black),
      ),

      listTileTheme: const ListTileThemeData(
        tileColor: Color.fromRGBO(210, 233, 245, 1),
        textColor: Colors.black,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
        iconColor: Colors.grey,
      ),

    );
  }
}
