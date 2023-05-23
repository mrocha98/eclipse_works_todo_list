import 'package:flutter/material.dart';

import '../../core/database/key_value_storage/key_value_storage.dart';
import 'theme_mode_repository.dart';

class ThemeModeRepositoryImpl implements ThemeModeRepository {
  ThemeModeRepositoryImpl(this._kvStorage);

  final KeyValueStorage _kvStorage;

  String get _themeModeKey => 'theme_mode';

  @override
  Future<ThemeMode?> getThemeMode() async {
    final cached = await _kvStorage.get<String>(_themeModeKey);
    if (cached == null) return null;
    return ThemeMode.values.byName(cached);
  }

  @override
  Future<void> save(ThemeMode themeMode) => _kvStorage.set<String>(
        _themeModeKey,
        themeMode.name,
      );
}
