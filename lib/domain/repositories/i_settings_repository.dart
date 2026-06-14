import 'package:flutter/material.dart';

abstract class ISettingsRepository {
  Future<ThemeMode> getThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}
