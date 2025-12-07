import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kuraimi/constants/app_strings.dart';
import 'package:kuraimi/screens/services/models/service_model.dart';
import 'package:kuraimi/themes/app_colors.dart';
import 'package:kuraimi/themes/app_theme.dart';

/// بطاقة عرض الخدمة
class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final bool isDarkMode;

  const ServiceCard({super.key, required this.service, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final serviceName = _getServiceName(s);
    final serviceDesc = _getServiceDesc(s);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: service.isActive
            ? () {
                HapticFeedback.lightImpact();
                service.onTap?.call();
                _showServiceDetails(context);
              }
            : null,
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          decoration: AppTheme.getCardDecoration(isDarkMode, borderRadius: 24.r),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الأيقونة والحالة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // الأيقونة
                  Container(
                    width: 56.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: service.isActive
                            ? [
                                Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                                Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                              ]
                            : [AppColors.textHint.withValues(alpha: 0.1), AppColors.textHint.withValues(alpha: 0.05)],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: service.isActive
                            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                            : AppColors.textHint.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        service.iconPath,
                        width: 32.w,
                        height: 32.h,
                        colorFilter: ColorFilter.mode(
                          service.isActive ? Theme.of(context).colorScheme.primary : AppColors.textHint,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),

                  // علامة الشائع أو قريباً
                  if (service.isPopular && service.isActive)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [AppColors.secondaryColor, AppColors.secondaryColor.withValues(alpha: 0.8)]),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(color: AppColors.secondaryColor.withValues(alpha: 0.3), blurRadius: 8.r, offset: Offset(0, 4.h)),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rounded, size: 14.sp, color: Colors.white),
                          SizedBox(width: 4.w),
                          Text(
                            s.popularServices.split(' ')[0], // 'شائع' أو 'Popular'
                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  else if (!service.isActive)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.textHint.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        s.comingSoon,
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColors.textHint),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 16.h),

              // اسم الخدمة
              Text(
                serviceName,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: service.isActive ? AppTheme.getTextPrimaryColor(isDarkMode) : AppColors.textHint,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 8.h),

              // وصف الخدمة
              Expanded(
                child: Text(
                  serviceDesc,
                  style: TextStyle(
                    fontSize: 13.sp,
                    height: 1.4,
                    color: service.isActive ? AppTheme.getTextSecondaryColor(isDarkMode) : AppColors.textHint,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 12.h),

              // زر الإجراء
              if (service.isActive)
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withValues(alpha: 0.8)],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 12.r,
                        offset: Offset(0, 6.h),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        _showServiceDetails(context);
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              s.learnMore,
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            SizedBox(width: 6.w),
                            Icon(Icons.arrow_back_rounded, size: 16.sp, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getServiceName(AppStrings s) {
    switch (service.nameKey) {
      case 'serviceEDCard':
        return s.serviceEDCard;
      case 'serviceHasseb':
        return s.serviceHasseb;
      case 'serviceKuraimiExpress':
        return s.serviceKuraimiExpress;
      case 'serviceKuraimiTasdeed':
        return s.serviceKuraimiTasdeed;
      case 'serviceMFloos':
        return s.serviceMFloos;
      case 'serviceMashroaeeFinance':
        return s.serviceMashroaeeFinance;
      default:
        return service.nameKey;
    }
  }

  String _getServiceDesc(AppStrings s) {
    switch (service.descriptionKey) {
      case 'serviceEDCardDesc':
        return s.serviceEDCardDesc;
      case 'serviceHassebDesc':
        return s.serviceHassebDesc;
      case 'serviceKuraimiExpressDesc':
        return s.serviceKuraimiExpressDesc;
      case 'serviceKuraimiTasdeedDesc':
        return s.serviceKuraimiTasdeedDesc;
      case 'serviceMFloosDesc':
        return s.serviceMFloosDesc;
      case 'serviceMashroaeeFinanceDesc':
        return s.serviceMashroaeeFinanceDesc;
      default:
        return service.descriptionKey;
    }
  }

  void _showServiceDetails(BuildContext context) {
    final s = AppStrings.of(context);
    final serviceName = _getServiceName(s);
    final serviceDesc = _getServiceDesc(s);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: AppTheme.getSurfaceColor(isDarkMode),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(color: AppColors.textHint.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2.r)),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الأيقونة
                    Center(
                      child: Container(
                        width: 100.w,
                        height: 100.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                              Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(28.r),
                          border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2), width: 2),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            service.iconPath,
                            width: 56.w,
                            height: 56.h,
                            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // الاسم
                    Center(
                      child: Text(
                        serviceName,
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppTheme.getTextPrimaryColor(isDarkMode)),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // الوصف
                    Text(
                      serviceDesc,
                      style: TextStyle(fontSize: 15.sp, height: 1.6, color: AppTheme.getTextSecondaryColor(isDarkMode)),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 32.h),

                    // المميزات
                    Text(
                      'المميزات الرئيسية',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppTheme.getTextPrimaryColor(isDarkMode)),
                    ),

                    SizedBox(height: 16.h),

                    _buildFeatureItem(context, Icons.speed, 'سريع وآمن'),
                    _buildFeatureItem(context, Icons.verified_user, 'موثوق ومضمون'),
                    _buildFeatureItem(context, Icons.support_agent, 'دعم على مدار الساعة'),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),

            // زر التفعيل
            Container(
              padding: EdgeInsets.all(24.w),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تم تفعيل خدمة $serviceName'),
                        backgroundColor: AppColors.successColor,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                    );
                  },
                  child: Text(s.activate),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 20.sp, color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15.sp, color: AppTheme.getTextPrimaryColor(isDarkMode)),
            ),
          ),
        ],
      ),
    );
  }
}
