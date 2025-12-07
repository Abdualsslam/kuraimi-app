import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// ثيم التطبيق الشامل - متوافق مع شاشة تسجيل الدخول وجميع الشاشات
/// يدعم الوضع الفاتح والداكن مع تصميم Material 3
class AppTheme {
  // ==================== قيم ثابتة للثيم ====================
  static const double _borderRadiusSmall = 10.0;
  static const double _borderRadiusMedium = 15.0;
  static const double _borderRadiusLarge = 20.0;
  static const double _borderRadiusXLarge = 24.0;
  static const double _borderRadiusXXLarge = 28.0;

  static const double _elevationNone = 0.0;
  static const double _elevationLow = 2.0;
  static const double _elevationMedium = 8.0;
  static const double _elevationHigh = 16.0;

  static const Duration _animationDuration = Duration(milliseconds: 300);

  // ==================== الثيم الفاتح ====================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: AppColors.primaryColorSwatch,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: AppTextStyles.fontFamily,

      // نظام الألوان - Material 3
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondaryColor,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.secondaryLight,
        onSecondaryContainer: AppColors.secondaryDark,
        tertiary: AppColors.infoColor,
        onTertiary: Colors.white,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.backgroundMid,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.borderLight,
        outlineVariant: AppColors.dividerColor,
        error: AppColors.errorColor,
        onError: Colors.white,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
      ),

      // شريط التطبيق - متوافق مع AppBarLogin
      appBarTheme: const AppBarTheme(
        elevation: _elevationNone,
        scrolledUnderElevation: _elevationLow,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: AppTextStyles.appBarTitle,
        centerTitle: true,
        titleSpacing: 0,
      ),

      // الأزرار المرفوعة - متوافقة مع LoginButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.primaryColor.withOpacity(0.5),
              disabledForegroundColor: Colors.white.withOpacity(0.7),
              elevation: _elevationMedium,
              shadowColor: AppColors.primaryColor.withOpacity(0.4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusXLarge)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              minimumSize: const Size(double.infinity, 56),
              textStyle: AppTextStyles.buttonText,
              animationDuration: _animationDuration,
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.white.withOpacity(0.2);
                }
                if (states.contains(WidgetState.hovered)) {
                  return Colors.white.withOpacity(0.1);
                }
                return null;
              }),
            ),
      ),

      // الأزرار المحددة
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.primaryColor, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusXLarge)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              minimumSize: const Size(double.infinity, 56),
              textStyle: AppTextStyles.buttonOutlinedText,
              animationDuration: _animationDuration,
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.primaryColor.withOpacity(0.15);
                }
                if (states.contains(WidgetState.hovered)) {
                  return AppColors.primaryColor.withOpacity(0.08);
                }
                return null;
              }),
            ),
      ),

      // أزرار النص
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              textStyle: AppTextStyles.buttonTextStyle,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusSmall)),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.primaryColor.withOpacity(0.15);
                }
                return null;
              }),
            ),
      ),

      // أزرار الأيقونات - متوافقة مع BiometricSection
      iconButtonTheme: IconButtonThemeData(
        style:
            IconButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              backgroundColor: Colors.transparent,
              disabledForegroundColor: AppColors.textDisabled,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusLarge)),
              padding: const EdgeInsets.all(12),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.primaryColor.withOpacity(0.2);
                }
                if (states.contains(WidgetState.hovered)) {
                  return AppColors.primaryColor.withOpacity(0.1);
                }
                return null;
              }),
            ),
      ),

      // الأزرار العائمة
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: _elevationMedium,
        focusElevation: _elevationHigh,
        hoverElevation: _elevationHigh,
        highlightElevation: _elevationHigh,
        splashColor: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusLarge)),
      ),

      // حقول الإدخال - متوافقة مع LoginForm
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.borderLight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: BorderSide(color: AppColors.borderLight.withOpacity(0.5), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        labelStyle: AppTextStyles.inputLabel,
        floatingLabelStyle: AppTextStyles.inputLabel.copyWith(color: AppColors.primaryColor),
        hintStyle: AppTextStyles.inputHint,
        errorStyle: AppTextStyles.inputError,
        helperStyle: AppTextStyles.bodySmall,
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
        iconColor: AppColors.primaryColor,
        errorMaxLines: 2,
        isDense: false,
        alignLabelWithHint: true,
      ),

      // البطاقات - متوافقة مع Container في LoginScreen
      cardTheme: CardThemeData(
        elevation: _elevationMedium,
        shadowColor: AppColors.primaryColor.withOpacity(0.08),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadiusXXLarge),
          side: BorderSide(color: AppColors.primaryColor.withOpacity(0.1), width: 1),
        ),
        color: AppColors.surfaceLight,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        clipBehavior: Clip.antiAlias,
      ),

      // القوائم - متوافقة مع ListTile في الحوارات
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        titleTextStyle: AppTextStyles.listTileTitle,
        subtitleTextStyle: AppTextStyles.listTileSubtitle,
        leadingAndTrailingTextStyle: AppTextStyles.bodySmall,
        iconColor: AppColors.primaryColor,
        tileColor: Colors.transparent,
        selectedTileColor: AppColors.primaryColor.withOpacity(0.1),
        selectedColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusSmall)),
        dense: false,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 16,
        minLeadingWidth: 40,
        minVerticalPadding: 8,
        enableFeedback: true,
      ),

      // أشرطة التقدم - متوافقة مع LoadingIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
        linearTrackColor: AppColors.backgroundMid,
        circularTrackColor: AppColors.backgroundMid,
        refreshBackgroundColor: AppColors.backgroundLight,
        linearMinHeight: 4,
      ),

      // التبديل
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.borderLight;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor.withOpacity(0.4);
          }
          return AppColors.borderLight;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return AppColors.borderLight;
        }),
        thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(Icons.check, size: 14, color: Colors.white);
          }
          return null;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 20,
      ),

      // مربعات الاختيار - متوافقة مع OptionsSection
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryColor.withOpacity(0.2);
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primaryColor.withOpacity(0.1);
          }
          return null;
        }),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const BorderSide(color: AppColors.primaryColor, width: 2);
          }
          return const BorderSide(color: AppColors.primaryColor, width: 2);
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 20,
        visualDensity: VisualDensity.standard,
      ),

      // أزرار الراديو
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.textSecondary;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryColor.withOpacity(0.2);
          }
          return null;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 20,
        visualDensity: VisualDensity.standard,
      ),

      // الحوارات - متوافقة مع AlertDialog في LoginScreen
      dialogTheme: DialogThemeData(
        elevation: _elevationHigh,
        shadowColor: Colors.black.withOpacity(0.2),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusLarge)),
        backgroundColor: AppColors.surfaceLight,
        titleTextStyle: AppTextStyles.dialogTitle,
        contentTextStyle: AppTextStyles.dialogContent,
        alignment: Alignment.center,
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        iconColor: AppColors.primaryColor,
      ),

      // شريط السحب السفلي - متوافق مع BottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent,
        elevation: _elevationHigh,
        shadowColor: Colors.black.withOpacity(0.15),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        showDragHandle: true,
        dragHandleColor: AppColors.textHint.withOpacity(0.4),
        dragHandleSize: const Size(40, 4),
        modalElevation: _elevationHigh,
        modalBackgroundColor: AppColors.surfaceLight,
        clipBehavior: Clip.antiAlias,
        constraints: const BoxConstraints(maxWidth: 640),
      ),

      // شريط الإشعارات - متوافق مع SnackBar في LoginScreen
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurface,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
        actionTextColor: AppColors.secondaryColor,
        disabledActionTextColor: AppColors.textDisabled,
        elevation: _elevationMedium,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusSmall)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        showCloseIcon: false,
        closeIconColor: Colors.white,
        actionOverflowThreshold: 0.5,
        width: null,
      ),

      // التنقل السفلي - متوافق مع BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textSecondary,
        elevation: _elevationMedium,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTextStyles.bottomNavSelected,
        unselectedLabelStyle: AppTextStyles.bottomNavUnselected,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        enableFeedback: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),

      // شريط التنقل Material 3
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        indicatorColor: AppColors.primaryColor.withOpacity(0.15),
        surfaceTintColor: Colors.transparent,
        elevation: _elevationLow,
        shadowColor: AppColors.shadowLight,
        height: 80,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryColor, size: 24);
          }
          return const IconThemeData(color: AppColors.textSecondary, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyles.bottomNavSelected;
          }
          return AppTextStyles.bottomNavUnselected;
        }),
      ),

      // شريط التنقل الجانبي
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.surfaceLight,
        indicatorColor: AppColors.primaryColor.withOpacity(0.15),
        elevation: _elevationLow,
        useIndicator: true,
        groupAlignment: 0,
        labelType: NavigationRailLabelType.all,
        selectedIconTheme: const IconThemeData(color: AppColors.primaryColor, size: 24),
        unselectedIconTheme: const IconThemeData(color: AppColors.textSecondary, size: 24),
        selectedLabelTextStyle: AppTextStyles.bottomNavSelected,
        unselectedLabelTextStyle: AppTextStyles.bottomNavUnselected,
        minWidth: 72,
        minExtendedWidth: 256,
      ),

      // التبويبات - متوافقة مع TabBar
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.textSecondary,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 3),
          borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
        ),
        indicatorColor: AppColors.primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: AppTextStyles.tabSelected,
        unselectedLabelStyle: AppTextStyles.tabUnselected,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        dividerColor: AppColors.dividerColor,
        dividerHeight: 1,
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryColor.withOpacity(0.1);
          }
          return null;
        }),
        splashFactory: InkRipple.splashFactory,
        tabAlignment: TabAlignment.start,
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.backgroundMid,
        deleteIconColor: AppColors.textSecondary,
        disabledColor: AppColors.backgroundMid.withOpacity(0.5),
        selectedColor: AppColors.primaryColor.withOpacity(0.2),
        secondarySelectedColor: AppColors.secondaryColor.withOpacity(0.2),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusSmall)),
        labelStyle: AppTextStyles.labelMedium,
        secondaryLabelStyle: AppTextStyles.labelMedium,
        brightness: Brightness.light,
        elevation: 0,
        pressElevation: _elevationLow,
        iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 18),
      ),

      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryColor,
        inactiveTrackColor: AppColors.primaryColor.withOpacity(0.2),
        thumbColor: AppColors.primaryColor,
        overlayColor: AppColors.primaryColor.withOpacity(0.2),
        valueIndicatorColor: AppColors.primaryColor,
        valueIndicatorTextStyle: AppTextStyles.labelMedium.copyWith(color: Colors.white),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 2),
        activeTickMarkColor: Colors.white,
        inactiveTickMarkColor: AppColors.primaryColor.withOpacity(0.5),
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        showValueIndicator: ShowValueIndicator.onlyForContinuous,
      ),

      // Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.darkSurface.withOpacity(0.95),
          borderRadius: BorderRadius.circular(_borderRadiusSmall),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        textStyle: AppTextStyles.bodySmall.copyWith(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.all(8),
        preferBelow: true,
        verticalOffset: 20,
        waitDuration: const Duration(milliseconds: 500),
        showDuration: const Duration(milliseconds: 1500),
        triggerMode: TooltipTriggerMode.longPress,
        enableFeedback: true,
      ),

      // القائمة المنبثقة
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent,
        elevation: _elevationMedium,
        shadowColor: AppColors.shadowLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusMedium)),
        textStyle: AppTextStyles.bodyMedium,
        labelTextStyle: WidgetStateProperty.all(AppTextStyles.bodyMedium),
        enableFeedback: true,
        position: PopupMenuPosition.under,
        iconColor: AppColors.primaryColor,
        iconSize: 20,
      ),

      // المقسمات
      dividerTheme: const DividerThemeData(color: AppColors.dividerColor, thickness: 1, space: 1, indent: 0, endIndent: 0),

      // النصوص العامة
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // الأيقونات
      iconTheme: const IconThemeData(color: AppColors.primaryColor, size: 24, opticalSize: 24),

      // أيقونات أساسية
      primaryIconTheme: const IconThemeData(color: Colors.white, size: 24),

      // مؤشر التمرير
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.primaryColor.withOpacity(0.5)),
        trackColor: WidgetStateProperty.all(AppColors.backgroundMid),
        radius: const Radius.circular(10),
        thickness: WidgetStateProperty.all(6),
        thumbVisibility: WidgetStateProperty.all(false),
        trackVisibility: WidgetStateProperty.all(false),
        interactive: true,
        minThumbLength: 48,
        crossAxisMargin: 2,
        mainAxisMargin: 2,
      ),

      // تأثيرات اللمس
      splashFactory: InkSparkle.splashFactory,
      splashColor: AppColors.primaryColor.withOpacity(0.1),
      highlightColor: AppColors.primaryColor.withOpacity(0.05),
      hoverColor: AppColors.primaryColor.withOpacity(0.04),
      focusColor: AppColors.primaryColor.withOpacity(0.12),

      // Material 3 extensions
      extensions: const <ThemeExtension<dynamic>>[],

      // Page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),

      // Visual density
      visualDensity: VisualDensity.standard,

      // Material tap target size
      materialTapTargetSize: MaterialTapTargetSize.padded,

      // Platform specific
      platform: TargetPlatform.android,

      // Apply elevation overlay in dark mode
      applyElevationOverlayColor: false,
    );
  }

  // ==================== الثيم الداكن ====================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: AppColors.primaryColorSwatch,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: AppTextStyles.fontFamily,

      // نظام الألوان الداكن - Material 3
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.darkBackground,
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondaryColor,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.secondaryDark,
        onSecondaryContainer: AppColors.secondaryLight,
        tertiary: AppColors.infoColorDark,
        onTertiary: AppColors.darkBackground,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        surfaceContainerHighest: AppColors.darkSurfaceVariant,
        onSurfaceVariant: AppColors.darkTextSecondary,
        outline: AppColors.darkBorder,
        outlineVariant: AppColors.dividerColorDark,
        error: AppColors.errorColorDark,
        onError: AppColors.darkBackground,
        errorContainer: Color(0xFF93000A),
        onErrorContainer: Color(0xFFFFDAD6),
      ),

      // شريط التطبيق الداكن
      appBarTheme: const AppBarTheme(
        elevation: _elevationNone,
        scrolledUnderElevation: _elevationLow,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.darkTextPrimary,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: AppTextStyles.appBarTitleDark,
        centerTitle: true,
        titleSpacing: 0,
      ),

      // الأزرار المرفوعة الداكنة
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryLight,
              foregroundColor: AppColors.darkBackground,
              disabledBackgroundColor: AppColors.primaryLight.withOpacity(0.5),
              disabledForegroundColor: AppColors.darkBackground.withOpacity(0.7),
              elevation: _elevationMedium,
              shadowColor: AppColors.primaryLight.withOpacity(0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusXLarge)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              minimumSize: const Size(double.infinity, 56),
              textStyle: AppTextStyles.buttonTextDark,
              animationDuration: _animationDuration,
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.darkBackground.withOpacity(0.2);
                }
                if (states.contains(WidgetState.hovered)) {
                  return AppColors.darkBackground.withOpacity(0.1);
                }
                return null;
              }),
            ),
      ),

      // الأزرار المحددة الداكنة
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryLight,
              side: const BorderSide(color: AppColors.primaryLight, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusXLarge)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              minimumSize: const Size(double.infinity, 56),
              textStyle: AppTextStyles.buttonOutlinedText.copyWith(color: AppColors.primaryLight),
              animationDuration: _animationDuration,
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.primaryLight.withOpacity(0.15);
                }
                if (states.contains(WidgetState.hovered)) {
                  return AppColors.primaryLight.withOpacity(0.08);
                }
                return null;
              }),
            ),
      ),

      // أزرار النص الداكنة
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(
              foregroundColor: AppColors.primaryLight,
              textStyle: AppTextStyles.buttonTextStyle.copyWith(color: AppColors.primaryLight),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusSmall)),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.primaryLight.withOpacity(0.15);
                }
                return null;
              }),
            ),
      ),

      // أزرار الأيقونات الداكنة
      iconButtonTheme: IconButtonThemeData(
        style:
            IconButton.styleFrom(
              foregroundColor: AppColors.primaryLight,
              backgroundColor: Colors.transparent,
              disabledForegroundColor: AppColors.darkTextDisabled,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusLarge)),
              padding: const EdgeInsets.all(12),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.pressed)) {
                  return AppColors.primaryLight.withOpacity(0.2);
                }
                if (states.contains(WidgetState.hovered)) {
                  return AppColors.primaryLight.withOpacity(0.1);
                }
                return null;
              }),
            ),
      ),

      // الأزرار العائمة الداكنة
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.darkBackground,
        elevation: _elevationMedium,
        focusElevation: _elevationHigh,
        hoverElevation: _elevationHigh,
        highlightElevation: _elevationHigh,
        splashColor: AppColors.darkBackground.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusLarge)),
      ),

      // حقول الإدخال الداكنة
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.darkBorder, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.darkBorder, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.errorColorDark, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: const BorderSide(color: AppColors.errorColorDark, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_borderRadiusMedium),
          borderSide: BorderSide(color: AppColors.darkBorder.withOpacity(0.5), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        labelStyle: AppTextStyles.inputLabelDark,
        floatingLabelStyle: AppTextStyles.inputLabelDark.copyWith(color: AppColors.primaryLight),
        hintStyle: AppTextStyles.inputHintDark,
        errorStyle: AppTextStyles.inputErrorDark,
        helperStyle: AppTextStyles.bodySmallDark,
        prefixIconColor: AppColors.darkTextSecondary,
        suffixIconColor: AppColors.darkTextSecondary,
        iconColor: AppColors.primaryLight,
        errorMaxLines: 2,
        isDense: false,
        alignLabelWithHint: true,
      ),

      // البطاقات الداكنة
      cardTheme: CardThemeData(
        elevation: _elevationMedium,
        shadowColor: Colors.black.withOpacity(0.3),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadiusXXLarge),
          side: BorderSide(color: AppColors.primaryLight.withOpacity(0.1), width: 1),
        ),
        color: AppColors.darkSurface,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        clipBehavior: Clip.antiAlias,
      ),

      // القوائم الداكنة
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        titleTextStyle: AppTextStyles.listTileTitleDark,
        subtitleTextStyle: AppTextStyles.listTileSubtitleDark,
        leadingAndTrailingTextStyle: AppTextStyles.bodySmallDark,
        iconColor: AppColors.primaryLight,
        tileColor: Colors.transparent,
        selectedTileColor: AppColors.primaryLight.withOpacity(0.1),
        selectedColor: AppColors.primaryLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusSmall)),
        dense: false,
        visualDensity: VisualDensity.standard,
        horizontalTitleGap: 16,
        minLeadingWidth: 40,
        minVerticalPadding: 8,
        enableFeedback: true,
      ),

      // أشرطة التقدم الداكنة
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryLight,
        linearTrackColor: AppColors.darkSurfaceVariant,
        circularTrackColor: AppColors.darkSurfaceVariant,
        refreshBackgroundColor: AppColors.darkSurface,
        linearMinHeight: 4,
      ),

      // التبديل الداكن
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.darkTextDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.darkTextSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.darkBorder;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight.withOpacity(0.4);
          }
          return AppColors.darkBorder;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return AppColors.darkBorder;
        }),
        thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
          if (states.contains(WidgetState.selected)) {
            return const Icon(Icons.check, size: 14, color: AppColors.darkBackground);
          }
          return null;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 20,
      ),

      // مربعات الاختيار الداكنة
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.darkTextDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.darkBackground),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryLight.withOpacity(0.2);
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primaryLight.withOpacity(0.1);
          }
          return null;
        }),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const BorderSide(color: AppColors.primaryLight, width: 2);
          }
          return const BorderSide(color: AppColors.primaryLight, width: 2);
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 20,
        visualDensity: VisualDensity.standard,
      ),

      // أزرار الراديو الداكنة
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.darkTextDisabled;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.darkTextSecondary;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryLight.withOpacity(0.2);
          }
          return null;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 20,
        visualDensity: VisualDensity.standard,
      ),

      // الحوارات الداكنة
      dialogTheme: DialogThemeData(
        elevation: _elevationHigh,
        shadowColor: Colors.black.withOpacity(0.4),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusLarge)),
        backgroundColor: AppColors.darkSurface,
        titleTextStyle: AppTextStyles.dialogTitleDark,
        contentTextStyle: AppTextStyles.dialogContentDark,
        alignment: Alignment.center,
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        iconColor: AppColors.primaryLight,
      ),

      // شريط السحب السفلي الداكن
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        elevation: _elevationHigh,
        shadowColor: Colors.black.withOpacity(0.4),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        showDragHandle: true,
        dragHandleColor: AppColors.darkTextHint.withOpacity(0.4),
        dragHandleSize: const Size(40, 4),
        modalElevation: _elevationHigh,
        modalBackgroundColor: AppColors.darkSurface,
        clipBehavior: Clip.antiAlias,
        constraints: const BoxConstraints(maxWidth: 640),
      ),

      // شريط الإشعارات الداكن
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurfaceVariant,
        contentTextStyle: AppTextStyles.bodyMediumDark,
        actionTextColor: AppColors.secondaryColor,
        disabledActionTextColor: AppColors.darkTextDisabled,
        elevation: _elevationMedium,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusSmall)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        showCloseIcon: false,
        closeIconColor: AppColors.darkTextPrimary,
        actionOverflowThreshold: 0.5,
        width: null,
      ),

      // التنقل السفلي الداكن
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.darkTextSecondary,
        elevation: _elevationMedium,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTextStyles.bottomNavSelected.copyWith(color: AppColors.primaryLight),
        unselectedLabelStyle: AppTextStyles.bottomNavUnselected.copyWith(color: AppColors.darkTextSecondary),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        enableFeedback: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),

      // شريط التنقل Material 3 الداكن
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        indicatorColor: AppColors.primaryLight.withOpacity(0.15),
        surfaceTintColor: Colors.transparent,
        elevation: _elevationLow,
        shadowColor: AppColors.shadowDark,
        height: 80,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryLight, size: 24);
          }
          return const IconThemeData(color: AppColors.darkTextSecondary, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyles.bottomNavSelected.copyWith(color: AppColors.primaryLight);
          }
          return AppTextStyles.bottomNavUnselected.copyWith(color: AppColors.darkTextSecondary);
        }),
      ),

      // شريط التنقل الجانبي الداكن
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.darkSurface,
        indicatorColor: AppColors.primaryLight.withOpacity(0.15),
        elevation: _elevationLow,
        useIndicator: true,
        groupAlignment: 0,
        labelType: NavigationRailLabelType.all,
        selectedIconTheme: const IconThemeData(color: AppColors.primaryLight, size: 24),
        unselectedIconTheme: const IconThemeData(color: AppColors.darkTextSecondary, size: 24),
        selectedLabelTextStyle: AppTextStyles.bottomNavSelected.copyWith(color: AppColors.primaryLight),
        unselectedLabelTextStyle: AppTextStyles.bottomNavUnselected.copyWith(color: AppColors.darkTextSecondary),
        minWidth: 72,
        minExtendedWidth: 256,
      ),

      // التبويبات الداكنة
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primaryLight,
        unselectedLabelColor: AppColors.darkTextSecondary,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.primaryLight, width: 3),
          borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
        ),
        indicatorColor: AppColors.primaryLight,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: AppTextStyles.tabSelected.copyWith(color: AppColors.primaryLight),
        unselectedLabelStyle: AppTextStyles.tabUnselected.copyWith(color: AppColors.darkTextSecondary),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        dividerColor: AppColors.dividerColorDark,
        dividerHeight: 1,
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryLight.withOpacity(0.1);
          }
          return null;
        }),
        splashFactory: InkRipple.splashFactory,
        tabAlignment: TabAlignment.start,
      ),

      // Chips الداكنة
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurfaceVariant,
        deleteIconColor: AppColors.darkTextSecondary,
        disabledColor: AppColors.darkSurfaceVariant.withOpacity(0.5),
        selectedColor: AppColors.primaryLight.withOpacity(0.2),
        secondarySelectedColor: AppColors.secondaryColor.withOpacity(0.2),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusSmall)),
        labelStyle: AppTextStyles.labelMediumDark,
        secondaryLabelStyle: AppTextStyles.labelMediumDark,
        brightness: Brightness.dark,
        elevation: 0,
        pressElevation: _elevationLow,
        iconTheme: const IconThemeData(color: AppColors.darkTextSecondary, size: 18),
      ),

      // Slider الداكن
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryLight,
        inactiveTrackColor: AppColors.primaryLight.withOpacity(0.2),
        thumbColor: AppColors.primaryLight,
        overlayColor: AppColors.primaryLight.withOpacity(0.2),
        valueIndicatorColor: AppColors.primaryLight,
        valueIndicatorTextStyle: AppTextStyles.labelMediumDark.copyWith(color: AppColors.darkBackground),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 2),
        activeTickMarkColor: AppColors.darkBackground,
        inactiveTickMarkColor: AppColors.primaryLight.withOpacity(0.5),
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        showValueIndicator: ShowValueIndicator.onlyForContinuous,
      ),

      // Tooltip الداكن
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceVariant.withOpacity(0.95),
          borderRadius: BorderRadius.circular(_borderRadiusSmall),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        textStyle: AppTextStyles.bodySmallDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.all(8),
        preferBelow: true,
        verticalOffset: 20,
        waitDuration: const Duration(milliseconds: 500),
        showDuration: const Duration(milliseconds: 1500),
        triggerMode: TooltipTriggerMode.longPress,
        enableFeedback: true,
      ),

      // القائمة المنبثقة الداكنة
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        elevation: _elevationMedium,
        shadowColor: AppColors.shadowDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadiusMedium)),
        textStyle: AppTextStyles.bodyMediumDark,
        labelTextStyle: WidgetStateProperty.all(AppTextStyles.bodyMediumDark),
        enableFeedback: true,
        position: PopupMenuPosition.under,
        iconColor: AppColors.primaryLight,
        iconSize: 20,
      ),

      // المقسمات الداكنة
      dividerTheme: const DividerThemeData(color: AppColors.dividerColorDark, thickness: 1, space: 1, indent: 0, endIndent: 0),

      // النصوص العامة الداكنة
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLargeDark,
        displayMedium: AppTextStyles.displayMediumDark,
        displaySmall: AppTextStyles.displaySmallDark,
        headlineLarge: AppTextStyles.headlineLargeDark,
        headlineMedium: AppTextStyles.headlineMediumDark,
        headlineSmall: AppTextStyles.headlineSmallDark,
        titleLarge: AppTextStyles.titleLargeDark,
        titleMedium: AppTextStyles.titleMediumDark,
        titleSmall: AppTextStyles.titleSmallDark,
        bodyLarge: AppTextStyles.bodyLargeDark,
        bodyMedium: AppTextStyles.bodyMediumDark,
        bodySmall: AppTextStyles.bodySmallDark,
        labelLarge: AppTextStyles.labelLargeDark,
        labelMedium: AppTextStyles.labelMediumDark,
        labelSmall: AppTextStyles.labelSmallDark,
      ),

      // الأيقونات الداكنة
      iconTheme: const IconThemeData(color: AppColors.primaryLight, size: 24, opticalSize: 24),

      // أيقونات أساسية داكنة
      primaryIconTheme: const IconThemeData(color: AppColors.darkBackground, size: 24),

      // مؤشر التمرير الداكن
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.primaryLight.withOpacity(0.5)),
        trackColor: WidgetStateProperty.all(AppColors.darkSurfaceVariant),
        radius: const Radius.circular(10),
        thickness: WidgetStateProperty.all(6),
        thumbVisibility: WidgetStateProperty.all(false),
        trackVisibility: WidgetStateProperty.all(false),
        interactive: true,
        minThumbLength: 48,
        crossAxisMargin: 2,
        mainAxisMargin: 2,
      ),

      // تأثيرات اللمس الداكنة
      splashFactory: InkSparkle.splashFactory,
      splashColor: AppColors.primaryLight.withOpacity(0.1),
      highlightColor: AppColors.primaryLight.withOpacity(0.05),
      hoverColor: AppColors.primaryLight.withOpacity(0.04),
      focusColor: AppColors.primaryLight.withOpacity(0.12),

      // Material 3 extensions
      extensions: const <ThemeExtension<dynamic>>[],

      // Page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),

      // Visual density
      visualDensity: VisualDensity.standard,

      // Material tap target size
      materialTapTargetSize: MaterialTapTargetSize.padded,

      // Platform specific
      platform: TargetPlatform.android,

      // Apply elevation overlay in dark mode
      applyElevationOverlayColor: true,
    );
  }

  // ==================== دوال مساعدة ====================

  /// الحصول على لون السطح حسب الوضع
  static Color getSurfaceColor(bool isDarkMode) {
    return isDarkMode ? AppColors.darkSurface : AppColors.surfaceLight;
  }

  /// الحصول على لون الخلفية حسب الوضع
  static Color getBackgroundColor(bool isDarkMode) {
    return isDarkMode ? AppColors.darkBackground : AppColors.backgroundLight;
  }

  /// الحصول على لون النص الأساسي حسب الوضع
  static Color getTextPrimaryColor(bool isDarkMode) {
    return isDarkMode ? AppColors.darkTextPrimary : AppColors.textPrimary;
  }

  /// الحصول على لون النص الثانوي حسب الوضع
  static Color getTextSecondaryColor(bool isDarkMode) {
    return isDarkMode ? AppColors.darkTextSecondary : AppColors.textSecondary;
  }

  /// الحصول على لون الحدود حسب الوضع
  static Color getBorderColor(bool isDarkMode) {
    return isDarkMode ? AppColors.darkBorder : AppColors.borderLight;
  }

  /// الحصول على لون الظل حسب الوضع
  static Color getShadowColor(bool isDarkMode) {
    return isDarkMode ? AppColors.shadowDark : AppColors.shadowLight;
  }

  /// الحصول على BoxDecoration للبطاقات
  static BoxDecoration getCardDecoration(bool isDarkMode, {double? borderRadius}) {
    return BoxDecoration(
      color: getSurfaceColor(isDarkMode),
      borderRadius: BorderRadius.circular(borderRadius ?? _borderRadiusXXLarge),
      boxShadow: [
        BoxShadow(
          color: isDarkMode ? Colors.black.withOpacity(0.3) : AppColors.primaryColor.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 2,
        ),
      ],
      border: Border.all(color: isDarkMode ? AppColors.primaryLight.withOpacity(0.1) : AppColors.primaryColor.withOpacity(0.1), width: 1),
    );
  }

  /// الحصول على BoxDecoration للأزرار التفاعلية
  static BoxDecoration getInteractiveDecoration(bool isDarkMode, {double? borderRadius}) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDarkMode ? [AppColors.darkSurface, AppColors.darkSurfaceVariant] : [AppColors.surfaceLight, AppColors.backgroundLight],
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? _borderRadiusLarge),
      border: Border.all(color: isDarkMode ? AppColors.primaryLight.withOpacity(0.3) : AppColors.primaryColor.withOpacity(0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: isDarkMode ? AppColors.primaryLight.withOpacity(0.15) : AppColors.primaryColor.withOpacity(0.15),
          blurRadius: 15,
          offset: const Offset(0, 5),
          spreadRadius: 1,
        ),
      ],
    );
  }
}
