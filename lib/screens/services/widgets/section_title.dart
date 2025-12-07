import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuraimi/themes/app_theme.dart';

/// عنوان القسم
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onSeeAll;
  final bool isDarkMode;

  const SectionTitle({super.key, required this.title, this.subtitle, this.icon, this.onSeeAll, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          // الأيقونة
          if (icon != null) ...[
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                    Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, size: 20.sp, color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(width: 12.w),
          ],

          // العناوين
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppTheme.getTextPrimaryColor(isDarkMode)),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    subtitle!,
                    style: TextStyle(fontSize: 13.sp, color: AppTheme.getTextSecondaryColor(isDarkMode)),
                  ),
                ],
              ],
            ),
          ),

          // زر عرض الكل
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'عرض الكل',
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.arrow_back_ios_rounded, size: 14.sp, color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
