import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(

      fontFamily: 'gotham',

      primaryColor: const Color.fromRGBO(6, 147, 253, 1),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color.fromRGBO(20, 154, 255, 1.0),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Color.fromRGBO(44, 44, 44, 1.0),
          fontFamily: "roboto"
        ),
        iconTheme: IconThemeData(
            color: Color.fromRGBO(44, 44, 44, 1.0)
        ),
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
        titleLarge: TextStyle(
            color: Colors.white70,
            fontFamily: "gotham"
        ),
        headlineSmall: TextStyle(
            color: Color.fromRGBO(58, 58, 58, 1.0)
        ),
        bodyLarge: TextStyle(
            color: Color.fromRGBO(58, 58, 58, 1.0)
        ),
        labelLarge: TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0),
          fontFamily: "Lato"
        )
      ),

      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white70,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
            width: 0.10,
            style: BorderStyle.none,
            color: Color.fromRGBO(58, 58, 58, 1.0),
          )
        ),
        labelStyle: TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0),
          fontWeight: FontWeight.w700,
        )
      ),

      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(6, 135, 232, 1.0),
        primaryContainer: Colors.black,
        secondary: Colors.deepOrange,
        onSecondary: Colors.white,
        secondaryContainer: Colors.red,
        tertiary: Colors.red,
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

      fontFamily: 'gotham',

      primaryColor: Colors.black,

      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Color.fromRGBO(5, 21, 30, 1.0),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Colors.white70,
          fontFamily: "roboto"
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromRGBO(33, 160, 255, 1.0),
        surfaceTintColor: Colors.red,
      ),

      scaffoldBackgroundColor: const Color.fromRGBO(7, 26, 38, 1.0),

      splashColor: Colors.transparent,

      iconTheme: const IconThemeData(
          color: Colors.white70
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white70,
          fontFamily: "gotham"
        ),
        headlineSmall: TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0)
        ),
        bodyLarge: TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0)
        ),
        labelLarge: TextStyle(
          color: Colors.white70,
          fontFamily: "gotham"
        )
      ),

      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color.fromRGBO(9, 33, 51, 1.0),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                width: 0.10,
                style: BorderStyle.none,
                color: Color.fromRGBO(185, 185, 185, 1.0),
              )
          ),
          labelStyle: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w700,
          )
      ),

      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(6, 135, 232, 1.0),
        primaryContainer: Colors.white,
        secondary: Colors.deepOrange,
        onSecondary: Colors.white,
        secondaryContainer: Colors.red,
        tertiary: Colors.red,
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
