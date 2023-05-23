import 'package:flutter/material.dart';

abstract interface class ThemeModeRepository {
  Future<ThemeMode?> getThemeMode();
  Future<void> save(ThemeMode themeMode);
}
