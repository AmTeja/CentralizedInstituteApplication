import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF295be9);
const Color primaryColorLight = Color(0xFF7188ff);
const Color primaryColorDark = Color(0xFF0033b6);

const Color secondaryColor = Color(0xFFededf2);
const Color secondaryColorLight = Color(0xFFffffff);
const Color secondaryColorDark = Color(0xFFbbbbbf);

const Color secondaryTextColor = Color(0xFF3D3D3D);

const List<Color> colorsForChart = [
  primaryColor,
  Color(0xFFBECFFF),
  Color(0xFF1036B0),
  Color(0xFF9AF080)
];

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFEDEDF2),
    fontFamily: 'Nirmala',
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    colorScheme: const ColorScheme.light(
      secondary: secondaryColor,
      ),
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {

  const Color textColor = Color(0xFF3B3B3B);

  return const TextTheme(
    headline1: TextStyle(
      color: textColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: textColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: textColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headline5: TextStyle(
      color: textColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      color: textColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyText1: TextStyle(
      color: textColor,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: TextStyle(
      color: textColor,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
  );
}