import 'package:flutter/material.dart';

class AppColors {
  // الألوان الأساسية
  static const Color primaryColor = Color(0xFF6E44AD);
  static const Color primaryDark = Color(0xFF5A378C);
  static const Color primaryLight = Color(0xFF8C6BBF);
  static const Color primaryAccent = Color(0xFF6E44AD); // Using the same as primary for now

  static const Color secondaryColor = Color(0xFFFF8500);
  static const Color secondaryDark = Color(0xFFCC6A00);
  static const Color secondaryLight = Color(0xFFFF9D33);
  static const Color secondaryAccent = Color(0xFFFF8500);

  // MaterialColor للثيم
  static const MaterialColor primaryColorSwatch = MaterialColor(0xFF6E44AD, <int, Color>{
    50: Color(0xFFF0EBF6),
    100: Color(0xFFD8C9E6),
    200: Color(0xFFBFB0D6),
    300: Color(0xFFA696C6),
    400: Color(0xFF9280B9),
    500: Color(0xFF6E44AD),
    600: Color(0xFF663D9F),
    700: Color(0xFF5A378C),
    800: Color(0xFF4F307A),
    900: Color(0xFF3D225C),
  });

  static const MaterialColor secondaryColorSwatch = MaterialColor(0xFFFF8500, <int, Color>{
    50: Color(0xFFFFF3E0),
    100: Color(0xFFFFE0B2),
    200: Color(0xFFFFCC80),
    300: Color(0xFFFFB74D),
    400: Color(0xFFFFA726),
    500: Color(0xFFFF8500),
    600: Color(0xFFFB8C00),
    700: Color(0xFFF57C00),
    800: Color(0xFFEF6C00),
    900: Color(0xFFE65100),
  });

  // ألوان الخلفية - الفاتحة
  static const Color backgroundLight = Color(0xFFebeafc);
  static const Color backgroundMid = Color(0xFFF0F7FF);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  // ألوان الخلفية - الداكنة
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2C);
  static const Color darkBorder = Color(0xFF404040);

  // ألوان النص - الفاتحة
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // ألوان النص - الداكنة
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextHint = Color(0xFF808080);
  static const Color darkTextDisabled = Color(0xFF606060);

  // ألوان الحالات
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color errorColor = Color(0xFFF44336);
  static const Color infoColor = Color(0xFF2196F3);

  // ألوان الحالات الداكنة
  static const Color successColorDark = Color(0xFF66BB6A);
  static const Color warningColorDark = Color(0xFFFFB74D);
  static const Color errorColorDark = Color(0xFFEF5350);
  static const Color infoColorDark = Color(0xFF42A5F5);

  // ألوان الظلال
  static Color get shadowLight => primaryColor.withOpacity(0.2);
  static Color get shadowDark => Colors.black.withOpacity(0.4);

  // ألوان المؤشرات
  static const Color loadingIndicator = primaryColor;
  static const Color loadingIndicatorDark = primaryLight;

  // ألوان الحدود
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderFocused = primaryColor;
  static const Color borderError = errorColor;

  // ألوان خاصة بالتطبيق
  static const Color cardBackground = backgroundWhite;
  static const Color cardBackgroundDark = darkSurface;
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color dividerColorDark = Color(0xFF404040);

  // شفافيات مفيدة
  static Color get overlay => Colors.black.withOpacity(0.5);
  static Color get overlayLight => Colors.white.withOpacity(0.8);
  static Color get shimmer => Colors.grey.withOpacity(0.3);
  static Color get shimmerDark => Colors.white.withOpacity(0.1);
}

// lib/themes/app_text_styles.dart
