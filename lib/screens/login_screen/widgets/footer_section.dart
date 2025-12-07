import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kuraimi/constants/assets.dart';
import 'package:kuraimi/themes/app_colors.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/app_strings.dart';
import '../../../themes/app_text_styles.dart';

class FooterSection extends StatelessWidget {
  final bool isDarkMode;
  final Function(String) onFooterLinkTap;

  const FooterSection({super.key, required this.isDarkMode, required this.onFooterLinkTap});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Column(
      children: [
        Container(
          height: 1.h,
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.transparent, CupertinoColors.inactiveGray, Colors.transparent]),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _buildFooterLink(context, Lottie.asset(Assets.iconQrScan, height: 40.h), s.supportComputer, isDarkMode)),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildFooterLink(
                context,
                SvgPicture.asset(Assets.iconWhatsapp, color: Theme.of(context).colorScheme.primary, height: 40.h),
                s.whatsapp,
                isDarkMode,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),

          child: Text(
            s.version,
            style: AppTextStyles.versionText.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLink(BuildContext context, Widget iconWidget, String text, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        onFooterLinkTap(text);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.darkSurface : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), blurRadius: 10.r, offset: Offset(0, 4.h))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            SizedBox(height: 8.h),
            Text(
              text,
              style: (isDarkMode ? AppTextStyles.footerLinkDark : AppTextStyles.footerLink).copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
