import 'package:flutter/material.dart';

final ThemeData profileLightTheme = ThemeData(
      brightness: Brightness.light,
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
    );



final ThemeData profileDarkTheme = ThemeData(

      listTileTheme: ListTileThemeData(
        tileColor: const Color.fromRGBO(9, 33, 51, 1.0),
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
            borderRadius: BorderRadius.circular(25.5)
        ),
      ),

    );

