import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kuraimi/constants/app_strings.dart';
import 'package:kuraimi/providers/theme_cubit.dart';
import 'package:kuraimi/screens/services/data/services_data.dart';
import 'package:kuraimi/screens/services/models/service_model.dart';
import 'package:kuraimi/screens/services/widgets/section_title.dart';
import 'package:kuraimi/screens/services/widgets/service_card.dart';
import 'package:kuraimi/screens/services/widgets/services_header.dart';
import 'package:kuraimi/themes/app_gradients.dart';
import 'package:kuraimi/widgets/bottom_navigation.dart';

/// صفحة الخدمات
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state.isDarkMode;
    final s = AppStrings.of(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          extendBody: true,
          body: Container(
            decoration: BoxDecoration(gradient: AppGradients.backgroundGradient(isDarkMode)),
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      // الرأس
                      SliverToBoxAdapter(child: ServicesHeader(isDarkMode: isDarkMode)),

                      // الخدمات الشائعة
                      SliverToBoxAdapter(
                        child: SectionTitle(
                          title: s.popularServices,
                          subtitle: 'الخدمات الأكثر استخداماً',
                          icon: Icons.stars_rounded,
                          isDarkMode: isDarkMode,
                        ),
                      ),

                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio: 0.85,
                          ),
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final popularServices = ServicesData.getPopularServices();
                            if (index >= popularServices.length) return null;
                            return ServiceCard(service: popularServices[index], isDarkMode: isDarkMode);
                          }, childCount: ServicesData.getPopularServices().length),
                        ),
                      ),

                      SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                      // جميع الخدمات
                      SliverToBoxAdapter(
                        child: SectionTitle(
                          title: s.allServices,
                          subtitle: 'استكشف جميع خدمات البنك',
                          icon: Icons.apps_rounded,
                          isDarkMode: isDarkMode,
                        ),
                      ),

                      // الخدمات المصرفية
                      SliverToBoxAdapter(child: _buildCategorySection(context, s.bankingServices, ServiceCategory.banking, isDarkMode)),

                      SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                      // الخدمات الرقمية
                      SliverToBoxAdapter(child: _buildCategorySection(context, s.digitalServices, ServiceCategory.digital, isDarkMode)),

                      SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                      // خدمات الدفع
                      SliverToBoxAdapter(child: _buildCategorySection(context, 'خدمات الدفع', ServiceCategory.payment, isDarkMode)),

                      SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                      // خدمات التمويل
                      SliverToBoxAdapter(child: _buildCategorySection(context, 'خدمات التمويل', ServiceCategory.finance, isDarkMode)),

                      // مساحة إضافية في الأسفل للـ Bottom Navigation Bar
                      SliverToBoxAdapter(child: SizedBox(height: 100.h)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomBar(currentTab: 3, onTabSelected: (index) => _handleTabNavigation(context, index)),
        );
      },
    );
  }

  Widget _buildCategorySection(BuildContext context, String categoryName, ServiceCategory category, bool isDarkMode) {
    final services = ServicesData.getServicesByCategory(category);

    if (services.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 4.w,
                height: 20.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)],
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                categoryName,
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 240.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: services.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 180.w,
                child: ServiceCard(service: services[index], isDarkMode: isDarkMode),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleTabNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/profile');
        break;
      case 1:
        context.go('/transactions');
        break;
      case 2:
        context.go('/home');
        break;
      case 3:
        context.go('/services');
        break;
      case 4:
        context.go('/settings');
        break;
    }
  }
}
