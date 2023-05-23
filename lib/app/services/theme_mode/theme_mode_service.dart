import 'package:flutter/material.dart';

abstract interface class ThemeModeService {
  Future<ThemeMode?> getThemeMode();
  Future<void> save(ThemeMode themeMode);
}
