import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define ThemeState
class ThemeState {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  // Helper to get if current theme is dark mode
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  // Helper to get if current theme is light mode
  bool get isLightMode {
    if (themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.light;
    }
    return themeMode == ThemeMode.light;
  }

  // Helper to get if current theme is system mode
  bool get isSystemMode => themeMode == ThemeMode.system;

  // Helper to get current theme name
  String get currentThemeName {
    switch (themeMode) {
      case ThemeMode.light:
        return 'فاتح';
      case ThemeMode.dark:
        return 'داكن';
      case ThemeMode.system:
        return 'النظام';
    }
  }

  // Helper to get current theme icon
  IconData get currentThemeIcon {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_system_daydream;
    }
  }
}

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeCubit() : super(const ThemeState(ThemeMode.system)) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
      final themeMode = ThemeMode.values[themeModeIndex];
      emit(ThemeState(themeMode));
    } catch (e) {
      print('Error loading theme: $e');
      emit(const ThemeState(ThemeMode.system));
    }
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, themeMode.index);
    } catch (e) {
      print('Error saving theme: $e');
      // يمكن إضافة معالجة إضافية هنا
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    if (state.themeMode != themeMode) {
      await _saveThemeMode(themeMode);
      emit(ThemeState(themeMode));
    }
  }

  Future<void> toggleTheme() async {
    ThemeMode newThemeMode;
    switch (state.themeMode) {
      case ThemeMode.light:
        newThemeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newThemeMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        newThemeMode = ThemeMode.light;
        break;
    }
    await setThemeMode(newThemeMode);
  }
}
