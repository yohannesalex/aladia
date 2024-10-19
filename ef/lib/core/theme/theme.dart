import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: Colors.black,
        secondary: const Color.fromARGB(255, 201, 198, 198),
        tertiary: Colors.grey[500],
        inversePrimary: const Color.fromARGB(255, 85, 84, 84)));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        background: Colors.black,
        primary: Colors.white,
        secondary: Color.fromARGB(255, 71, 70, 70),
        tertiary: Colors.white,
        inversePrimary: Color.fromARGB(255, 132, 129, 129)));
