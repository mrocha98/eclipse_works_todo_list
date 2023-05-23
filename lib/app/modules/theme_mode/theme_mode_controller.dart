import 'package:flutter/material.dart';

import '../../services/theme_mode/theme_mode_service.dart';

class ThemeModeController extends ChangeNotifier {
  ThemeModeController(this._themeModeService);

  final ThemeModeService _themeModeService;

  ThemeMode? _themeMode;

  ThemeMode? get themeMode => _themeMode;

  Future<void> init() async {
    _themeMode = await _themeModeService.getThemeMode();
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    print(themeMode);
    await _themeModeService.save(themeMode);
    _themeMode = themeMode;
    notifyListeners();
  }
}
