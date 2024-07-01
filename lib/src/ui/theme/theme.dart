import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color primaryColorDark = Color(0xFF6E6E6E);
const Color secondaryColor = Color(0xFF000000);

final myTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  primaryColorDark: primaryColorDark,

  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: primaryColor,
    iconTheme: IconThemeData(
      color: Colors.white
    )
  ), colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.black,
    secondary: secondaryColor,
    onSecondary: Colors.black,
    surface: primaryColor,
    onSurface: Colors.black,
    background: primaryColor,
    onBackground: Colors.black,
    error: Color(0xffb00020),
    onError: Colors.white,
  ),
);