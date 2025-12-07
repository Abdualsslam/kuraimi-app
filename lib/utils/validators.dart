// Validators with optional localization support.
import 'package:flutter/widgets.dart';
import '../constants/app_strings.dart';

class Validators {
  // التحقق من رقم المميز
  // Accepts an optional BuildContext to return localized messages.
  static String? validateUserId(String? value, [BuildContext? context]) {
    final s = context != null ? AppStrings.of(context) : null;
    if (value == null || value.isEmpty) {
      return s?.userIdRequired ?? 'يرجى إدخال رقم المميز';
    }
    if (value.length < 3) {
      return s?.userIdTooShort ?? 'رقم المميز يجب أن يكون أكثر من 3 أرقام';
    }
    return null;
  }

  // التحقق من كلمة المرور
  static String? validatePassword(String? value, [BuildContext? context]) {
    final s = context != null ? AppStrings.of(context) : null;
    if (value == null || value.isEmpty) {
      return s?.passwordRequired ?? 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 4) {
      return s?.passwordTooShort ?? 'كلمة المرور يجب أن تكون أكثر من 4 أحرف';
    }
    return null;
  }

  // التحقق من رقم الهاتف
  static String? validatePhone(String? value, [BuildContext? context]) {
    final s = context != null ? AppStrings.of(context) : null;
    if (value == null || value.isEmpty) {
      return s?.phoneRequired ?? 'يرجى إدخال رقم الهاتف';
    }
    if (!RegExp(r'^[0-9+]+$').hasMatch(value)) {
      return s?.phoneInvalid ?? 'رقم الهاتف غير صحيح';
    }
    return null;
  }

  // التحقق من البريد الإلكتروني
  static String? validateEmail(String? value, [BuildContext? context]) {
    final s = context != null ? AppStrings.of(context) : null;
    if (value == null || value.isEmpty) {
      return s?.emailRequired ?? 'يرجى إدخال البريد الإلكتروني';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(value)) {
      return s?.emailInvalid ?? 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }
}
