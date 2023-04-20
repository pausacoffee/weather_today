import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  dividerColor: Colors.white54,
);

const darkColorScheme = ColorScheme(
  background: Colors.black,
  brightness: Brightness.dark,
  error: Colors.red,
  onBackground: Colors.black87,
  onError: Colors.redAccent,
  onPrimary: Colors.lightBlue,
  onSecondary: Colors.lightBlueAccent,
  onSurface: Colors.black12,
  primary: Colors.lightBlue,
  secondary: Colors.lightBlueAccent,
  surface: Colors.black12,
);

const lightColorScheme = ColorScheme(
  background: Colors.amber,
  brightness: Brightness.light,
  error: Colors.red,
  onBackground: Colors.black87,
  onError: Colors.redAccent,
  onPrimary: Colors.amber,
  onSecondary: Colors.amberAccent,
  onSurface: Colors.black12,
  primary: Colors.amber,
  secondary: Colors.amberAccent,
  surface: Colors.black12,
);
