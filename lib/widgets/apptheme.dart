import 'package:flutter/material.dart';

class Apptheme{
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.amber
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black)
    )
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.blueGrey,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),

    )
  );
}