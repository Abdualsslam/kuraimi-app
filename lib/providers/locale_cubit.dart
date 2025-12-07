import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define LocaleState
class LocaleState {
  final Locale locale;

  const LocaleState(this.locale);
}

// Define LocaleCubit
class LocaleCubit extends Cubit<LocaleState> {
  static const String _localeKey = 'app_locale';

  LocaleCubit() : super(const LocaleState(Locale('ar'))) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey) ?? 'ar';
      emit(LocaleState(Locale(localeCode)));
    } catch (e) {
      emit(const LocaleState(Locale('ar')));
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (state.locale == locale) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
      emit(LocaleState(locale));
    } catch (e) {
      // Handle error silently
    }
  }

  void clearLocale() {
    emit(const LocaleState(Locale('ar')));
  }
}
