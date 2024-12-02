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
          color: Color.fromRGBO(17, 17, 17, 1.0),
          fontFamily: "gotham"
        ),
        iconTheme: IconThemeData(
            color: Color.fromRGBO(17, 17, 17, 1.0)
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
            color: Colors.white,
            fontFamily: "gotham"
        ),
        titleMedium: TextStyle(
            color: Colors.black54,
            fontFamily: "gotham"
        ),
        titleSmall: TextStyle(
            color: Colors.white,
            fontFamily: "gotham"
        ),
        headlineSmall: TextStyle(
            color: Color.fromRGBO(17, 17, 17, 1.0)
        ),
        bodyLarge: TextStyle(
            color: Color.fromRGBO(17, 17, 17, 1.0)
        ),
        bodyMedium: TextStyle(
            color: Color.fromRGBO(17, 17, 17, 1.0),
            fontFamily: "gotham"
        ),
        labelLarge: TextStyle(
          color: Color.fromRGBO(17, 17, 17, 1.0),
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
        unselectedItemColor: Colors.black54
      ),

      listTileTheme: ListTileThemeData(
        tileColor: const Color.fromRGBO(242, 248, 255, 1.0),
        textColor: Colors.black,
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.2
        ),
        subtitleTextStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14,
            height: 1.35
        ),
        iconColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.5)
        ),
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.5)
        ),
        //todayBackgroundColor: Color.fromRGBO(6, 135, 232, 1.0),
        headerBackgroundColor: const Color.fromRGBO(6, 135, 232, 1.0),
        yearStyle: const TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0),
          fontWeight: FontWeight.w700,
        ),
        rangePickerHeaderHelpStyle: const TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0),
          fontWeight: FontWeight.w700,
        ),
        headerHelpStyle: const TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0),
          fontWeight: FontWeight.w700,
        ),
        weekdayStyle: const TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0),
          fontWeight: FontWeight.w700,
        ),
        dayForegroundColor: const MaterialStatePropertyAll<Color>(Color.fromRGBO(58, 58, 58, 1.0)),
        cancelButtonStyle: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.red),
        ),
      )

    );
  } static ThemeData get dark {
    return ThemeData(

      fontFamily: 'gotham',

      primaryColor: const Color.fromRGBO(5, 21, 30, 1.0),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Color.fromRGBO(5, 21, 30, 1.0),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Colors.white70,
          fontFamily: "gotham"
        ),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromRGBO(7, 26, 38, 1.0),
        surfaceTintColor: Colors.red,
      ),

      scaffoldBackgroundColor: const Color.fromRGBO(7, 26, 38, 1.0),

      splashColor: Colors.transparent,

      iconTheme: const IconThemeData(
          color: Colors.white70,
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white70,
          fontFamily: "gotham",
          fontWeight: FontWeight.bold
        ),
        titleMedium: TextStyle(
          color: Colors.white70,
          fontFamily: "gotham"
        ),
        titleSmall: TextStyle(
          color: Colors.white,
          fontFamily: "gotham"
        ),
        headlineSmall: TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0)
        ),
        bodyLarge: TextStyle(
          color: Color.fromRGBO(58, 58, 58, 1.0)
        ),
        bodyMedium: TextStyle(
          color: Colors.white70,
          fontFamily: "gotham"
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
        backgroundColor: Colors.red,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(7, 26, 38, 1.0),
        selectedItemColor: Color.fromRGBO(20, 154, 255, 1.0),
        selectedLabelStyle: TextStyle(color: Colors.white70),
        unselectedItemColor: Colors.white54
      ),

      listTileTheme: ListTileThemeData(
        tileColor: const Color.fromRGBO(5, 23, 31, 0.9),
        textColor: Colors.white70,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          height: 1.2
        ),
        subtitleTextStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14,
            height: 1.35
        ),
        iconColor: Colors.white54,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.5)
        ),
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: const Color.fromRGBO(7, 26, 38, 1.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.5)
        ),
        //todayBackgroundColor: Color.fromRGBO(6, 135, 232, 1.0),
        headerBackgroundColor: const Color.fromRGBO(5, 21, 30, 1.0),
        headerForegroundColor: Colors.white,
        yearForegroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
        yearStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        rangePickerHeaderHelpStyle: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w700,
        ),


        todayForegroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
        headerHelpStyle: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w700,
        ),
        dayOverlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
        weekdayStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),

        dayForegroundColor: const MaterialStatePropertyAll<Color>(Colors.white70),
          //dayOverlayColor
        cancelButtonStyle: const ButtonStyle(
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.red),
        ),
        //cancelButtonStyle: ,
      )
    );
  }
}
