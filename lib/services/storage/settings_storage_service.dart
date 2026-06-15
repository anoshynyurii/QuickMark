import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SettingsStorageService {
  static const String _fileName = 'settings.json';
  String? _cachedPath;

  Future<File> _getSettingsFile() async {
    if (_cachedPath == null) {
      final dir = await getApplicationSupportDirectory();
      _cachedPath = dir.path;
    }
    return File('$_cachedPath/$_fileName');
  }

  Future<void> saveSettings(ThemeMode themeMode) async {
    try {
      final file = await _getSettingsFile();
      final Map<String, dynamic> settings = {
        'themeMode': themeMode.name,
      };

      await file.writeAsString(jsonEncode(settings));
    } catch (e) {
      debugPrint('Error saveSettings $e');
    }
  }

  Future<ThemeMode> loadThemeMode() async {
    try {
      final file = await _getSettingsFile();

      if (!await file.exists()) {
        return ThemeMode.light;
      }

      final String readFile = await file.readAsString();

      final Map<String, dynamic> settings = jsonDecode(readFile);

      final String themeString = settings['themeMode'];

      return ThemeMode.values.firstWhere(
        (e) => e.name == themeString,
        orElse: () => ThemeMode.light,
      );
    } catch (e) {
      debugPrint('Error loadThemeMode $e');
      return ThemeMode.light;
    }
  }
}
