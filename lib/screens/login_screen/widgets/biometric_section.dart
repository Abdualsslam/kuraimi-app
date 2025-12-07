import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuraimi/themes/app_colors.dart';
import '../../../constants/assets.dart';
import 'package:lottie/lottie.dart';

class BiometricSection extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onTap;
  const BiometricSection({super.key, required this.isDarkMode, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDarkMode
                  ? [AppColors.darkSurface, AppColors.darkSurfaceVariant]
                  : [AppColors.surfaceLight, AppColors.backgroundLight],
            ),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3), width: 2.w),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                blurRadius: 15.r,
                offset: Offset(0, 5.h),
                spreadRadius: 1.r,
              ),
            ],
          ),
          child: Center(
            child: Lottie.asset(Assets.iconFingerprintJson, fit: BoxFit.contain, height: 55.h),
          ),
        ),
      ),
    );
  }
}
