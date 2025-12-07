import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuraimi/constants/app_strings.dart';
import 'package:kuraimi/themes/app_theme.dart';

/// رأس صفحة الخدمات
class ServicesHeader extends StatelessWidget {
  final bool isDarkMode;

  const ServicesHeader({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان الرئيسي
          Text(
            s.servicesTitle,
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppTheme.getTextPrimaryColor(isDarkMode), height: 1.2),
          ),

          SizedBox(height: 8.h),

          // العنوان الفرعي
          Text(
            s.servicesSubtitle,
            style: TextStyle(fontSize: 15.sp, color: AppTheme.getTextSecondaryColor(isDarkMode), height: 1.4),
          ),

          SizedBox(height: 20.h),

          // شريط البحث
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppTheme.getSurfaceColor(isDarkMode),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppTheme.getBorderColor(isDarkMode), width: 1.5),
              boxShadow: [
                BoxShadow(color: AppTheme.getShadowColor(isDarkMode).withValues(alpha: 0.05), blurRadius: 10.r, offset: Offset(0, 4.h)),
              ],
            ),
            child: TextField(
              style: TextStyle(fontSize: 14.sp, color: AppTheme.getTextPrimaryColor(isDarkMode)),
              decoration: InputDecoration(
                hintText: 'ابحث عن خدمة...',
                hintStyle: TextStyle(fontSize: 14.sp, color: AppTheme.getTextSecondaryColor(isDarkMode)),
                prefixIcon: Icon(Icons.search_rounded, color: Theme.of(context).colorScheme.primary, size: 22.sp),
                suffixIcon: Icon(Icons.tune_rounded, color: AppTheme.getTextSecondaryColor(isDarkMode), size: 20.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
