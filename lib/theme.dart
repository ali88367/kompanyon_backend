import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static bool _isDarkMode = false;

  static Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
  }

  static Future<void> _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  static ThemeData get currentTheme {
    if (_isDarkMode) {
      return ThemeData.dark();
    } else {
      return ThemeData.light();
    }
  }

  static Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveTheme(_isDarkMode);
  }

  static Future<void> init() async {
    await _loadTheme();
  }
}