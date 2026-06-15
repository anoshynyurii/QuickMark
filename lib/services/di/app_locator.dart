import 'package:flutter/material.dart';
import 'package:quickmark/services/storage/settings_storage_service.dart';

class AppLocator {
  static late final SettingsStorageService settingsService;
  static late final ThemeMode initialTheme;

  static Future<void> init() async {
    settingsService = SettingsStorageService();
    initialTheme = await settingsService.loadThemeMode();
  }
}
