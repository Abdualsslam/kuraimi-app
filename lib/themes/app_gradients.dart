import 'package:flutter/material.dart';
import 'app_colors.dart';

/// تدرجات الألوان للتطبيق
/// متوافقة مع شاشة تسجيل الدخول وجميع الشاشات
class AppGradients {
  // ==================== التدرجات الأساسية ====================

  /// تدرج الألوان الأساسية - للأزرار والعناصر الرئيسية
  static LinearGradient get primaryGradient =>
      const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primaryColor, AppColors.primaryDark]);

  /// تدرج الألوان الأساسية العمودي
  static LinearGradient get primaryVerticalGradient => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.primaryColor, AppColors.primaryDark],
  );

  /// تدرج الألوان الأساسية الأفقي
  static LinearGradient get primaryHorizontalGradient => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.primaryColor, AppColors.primaryDark],
  );

  /// تدرج الألوان الأساسية الفاتحة
  static LinearGradient get primaryLightGradient =>
      const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primaryLight, AppColors.primaryColor]);

  // ==================== التدرجات الثانوية ====================

  /// تدرج الألوان الثانوية - للتأكيدات والإشارات
  static LinearGradient get secondaryGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.secondaryColor, AppColors.secondaryDark],
  );

  /// تدرج الألوان الثانوية العمودي
  static LinearGradient get secondaryVerticalGradient => const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.secondaryColor, AppColors.secondaryDark],
  );

  /// تدرج مختلط بين الأساسي والثانوي
  static LinearGradient get mixedGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryColor, AppColors.secondaryColor],
  );

  // ==================== تدرجات الخلفية ====================

  /// تدرج الخلفية حسب الوضع - متوافق مع LoginScreen
  static LinearGradient backgroundGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [AppColors.darkBackground, AppColors.darkSurface, AppColors.darkBackground]
          : [AppColors.backgroundLight, AppColors.backgroundMid, AppColors.backgroundLight],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  /// تدرج الخلفية العمودي
  static LinearGradient backgroundVerticalGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark ? [AppColors.darkBackground, AppColors.darkSurface] : [AppColors.backgroundLight, AppColors.backgroundMid],
    );
  }

  /// تدرج الخلفية مع لمسة اللون الأساسي
  static LinearGradient backgroundWithPrimaryTint(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [AppColors.darkBackground, AppColors.darkSurface, AppColors.primaryDark.withOpacity(0.1)]
          : [AppColors.backgroundLight, AppColors.backgroundMid, AppColors.primaryColor.withOpacity(0.05)],
      stops: const [0.0, 0.6, 1.0],
    );
  }

  // ==================== تدرجات البطاقات ====================

  /// تدرج للبطاقات - متوافق مع Container في LoginScreen
  static LinearGradient cardGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark ? [AppColors.darkSurface, AppColors.darkSurfaceVariant] : [AppColors.surfaceLight, AppColors.backgroundLight],
    );
  }

  /// تدرج للبطاقات مع تأثير زجاجي
  static LinearGradient cardGlassGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [AppColors.darkSurface.withOpacity(0.9), AppColors.darkSurfaceVariant.withOpacity(0.7)]
          : [AppColors.surfaceLight.withOpacity(0.9), AppColors.backgroundWhite.withOpacity(0.7)],
    );
  }

  /// تدرج للبطاقات المميزة
  static LinearGradient cardHighlightGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [AppColors.darkSurface, AppColors.primaryDark.withOpacity(0.15)]
          : [AppColors.surfaceLight, AppColors.primaryColor.withOpacity(0.08)],
    );
  }

  // ==================== تدرجات العناصر التفاعلية ====================

  /// تدرج للعناصر التفاعلية - متوافق مع BiometricSection
  static LinearGradient interactiveGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.8)],
    );
  }

  /// تدرج للأزرار - متوافق مع LoginButton
  static LinearGradient buttonGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark ? [AppColors.primaryLight, AppColors.primaryColor] : [AppColors.primaryColor, AppColors.primaryDark],
    );
  }

  /// تدرج للأزرار المعطلة
  static LinearGradient buttonDisabledGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark ? [AppColors.darkTextDisabled, AppColors.darkBorder] : [AppColors.textDisabled, AppColors.borderLight],
    );
  }

  /// تدرج للأزرار الثانوية
  static LinearGradient buttonSecondaryGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark ? [AppColors.secondaryColor, AppColors.secondaryDark] : [AppColors.secondaryColor, AppColors.secondaryDark],
    );
  }

  // ==================== تدرجات الحالات ====================

  /// تدرج النجاح
  static LinearGradient get successGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.successColor, AppColors.successColor.withOpacity(0.8)],
  );

  /// تدرج التحذير
  static LinearGradient get warningGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.warningColor, AppColors.warningColor.withOpacity(0.8)],
  );

  /// تدرج الخطأ
  static LinearGradient get errorGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.errorColor, AppColors.errorColor.withOpacity(0.8)],
  );

  /// تدرج المعلومات
  static LinearGradient get infoGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.infoColor, AppColors.infoColor.withOpacity(0.8)],
  );

  // ==================== تدرجات خاصة ====================

  /// تدرج شفاف للتراكبات - متوافق مع Loading Overlay
  static LinearGradient get overlayGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.7)],
  );

  /// تدرج للظلال
  static LinearGradient shadowGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, isDark ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.2)],
    );
  }

  /// تدرج للشريط العلوي
  static LinearGradient appBarGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark
          ? [AppColors.darkBackground, AppColors.darkBackground.withOpacity(0.0)]
          : [AppColors.backgroundLight, AppColors.backgroundLight.withOpacity(0.0)],
    );
  }

  /// تدرج للشريط السفلي
  static LinearGradient bottomBarGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: isDark
          ? [AppColors.darkSurface, AppColors.darkSurface.withOpacity(0.0)]
          : [AppColors.surfaceLight, AppColors.surfaceLight.withOpacity(0.0)],
    );
  }

  /// تدرج shimmer للتحميل
  static LinearGradient shimmerGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: isDark
          ? [AppColors.darkSurface, AppColors.darkSurfaceVariant, AppColors.darkSurface]
          : [AppColors.backgroundMid, AppColors.surfaceLight, AppColors.backgroundMid],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  /// تدرج للفاصل - متوافق مع FooterSection
  static LinearGradient get dividerGradient => const LinearGradient(colors: [Colors.transparent, AppColors.textHint, Colors.transparent]);

  // ==================== تدرجات شعاعية ====================

  /// تدرج شعاعي للخلفية
  static RadialGradient backgroundRadialGradient(bool isDark) {
    return RadialGradient(
      center: Alignment.topCenter,
      radius: 1.5,
      colors: isDark
          ? [AppColors.primaryDark.withOpacity(0.15), AppColors.darkBackground]
          : [AppColors.primaryColor.withOpacity(0.1), AppColors.backgroundLight],
    );
  }

  /// تدرج شعاعي للتأثيرات
  static RadialGradient glowGradient(Color color) {
    return RadialGradient(colors: [color.withOpacity(0.4), color.withOpacity(0.0)]);
  }

  // ==================== تدرجات مسحية ====================

  /// تدرج مسحي للمؤشرات الدائرية
  static SweepGradient progressGradient(bool isDark) {
    return SweepGradient(
      colors: isDark
          ? [AppColors.primaryLight, AppColors.primaryColor, AppColors.primaryDark, AppColors.primaryLight]
          : [AppColors.primaryColor, AppColors.primaryDark, AppColors.primaryColor],
    );
  }
}
