import 'package:flutter/material.dart';
import 'package:quickmark/services/storage/settings_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final SettingsStorageService _settingsStorageService;
  late ThemeMode themeMode;

  ThemeProvider(
    this._settingsStorageService, {
    required ThemeMode initTheme,
  }) {
    themeMode = initTheme;
  }

  Future<void> switchTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
    await _settingsStorageService.saveSettings(themeMode);
  }
}
