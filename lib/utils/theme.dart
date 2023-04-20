import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_today/utils/text.dart';

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  appBarTheme: appBarTheme,
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  dividerColor: Colors.black12,
  fontFamily: GoogleFonts.openSans().fontFamily,
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  appBarTheme: appBarTheme,
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  dividerColor: Colors.white54,
  fontFamily: GoogleFonts.openSans().fontFamily,
);

const darkColorScheme = ColorScheme(
  background: Color(0xFF424242),
  brightness: Brightness.dark,
  error: Colors.red,
  onBackground: Color(0xFF424242),
  onError: Colors.redAccent,
  onPrimary: Colors.lightBlue,
  onSecondary: Colors.lightBlueAccent,
  onSurface: Colors.black26,
  primary: Colors.lightBlue,
  secondary: Colors.lightBlueAccent,
  surface: Colors.black26,
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

AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  toolbarTextStyle: TextStylePath.title18w800,
  iconTheme: const IconThemeData(color: Colors.white),
  actionsIconTheme: const IconThemeData(color: Colors.white),
);
