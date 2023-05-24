import 'package:flutter/material.dart';

class LightTheme {
  LightTheme._internal();

  static const _primaryColor = Color(0xff3b82f6);

  static const _darkerPrimaryColor = Color(0xff172554);

  static ThemeData get theme => ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        fontFamily: 'Source Sans Pro',
        primaryColor: _primaryColor,
        scaffoldBackgroundColor: const Color(0xfff1f5f9),
        appBarTheme: const AppBarTheme(
          backgroundColor: _darkerPrimaryColor,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _darkerPrimaryColor,
          foregroundColor: Colors.white,
        ),
        toggleButtonsTheme: ToggleButtonsThemeData(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          selectedBorderColor: _primaryColor,
          selectedColor: Colors.white,
          fillColor: _primaryColor,
          color: Colors.grey.shade600,
        ),
      );
}
