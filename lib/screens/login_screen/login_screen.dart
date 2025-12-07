import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kuraimi/constants/app_strings.dart';
import 'package:kuraimi/providers/theme_cubit.dart';
import 'package:kuraimi/services/mock_services.dart';
import 'package:kuraimi/themes/app_colors.dart';
import 'package:kuraimi/themes/app_gradients.dart';
import 'package:kuraimi/themes/app_text_styles.dart';
import 'package:kuraimi/widgets/language_dialog.dart';
import 'package:kuraimi/widgets/loading_indicator.dart';
import 'package:kuraimi/widgets/snackbar_helper.dart';
import 'widgets/appbar_login.dart';
import 'widgets/banners_widget.dart';
import 'widgets/login_form.dart';
import 'widgets/biometric_section.dart';
import 'widgets/options_section.dart';
import 'widgets/footer_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
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
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    HapticFeedback.lightImpact();

    final success = await MockAuthService.loginWithCredentials(_userIdController.text, _passwordController.text);

    if (!mounted) return;

    setState(() => _isLoading = false);

    final strings = AppStrings.of(context);
    if (success) {
      SnackbarHelper.showSuccessSnackbar(context, strings.loginSuccess);
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) context.go('/home');
    } else {
      SnackbarHelper.showErrorSnackbar(context, strings.loginError);
    }
  }

  Future<void> _loginWithBiometric() async {
    HapticFeedback.mediumImpact();
    setState(() => _isLoading = true);

    final strings = AppStrings.of(context);
    final success = await MockAuthService.loginWithBiometric(localizedReason: strings.biometricPrompt);

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (success) {
      SnackbarHelper.showSuccessSnackbar(context, strings.loginSuccess);
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(strings.biometricFailed),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
      );
    }
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
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(gradient: AppGradients.backgroundGradient(isDarkMode)),
                child: SafeArea(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppBarLogin(),
                              // SizedBox(height: 16.h),
                              BannersWidget(),
                              SizedBox(height: 16.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  children: [
                                    // LoginForm داخل Container مع بطاقة خلفية
                                    Container(
                                      padding: EdgeInsets.all(16.w),
                                      decoration: BoxDecoration(
                                        color: isDarkMode ? AppColors.darkSurface : AppColors.surfaceLight,
                                        borderRadius: BorderRadius.circular(28.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                                            blurRadius: 20.r,
                                            offset: Offset(0, 8.h),
                                            spreadRadius: 2.r,
                                          ),
                                        ],
                                        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), width: 1.w),
                                      ),
                                      child: LoginForm(userIdController: _userIdController, passwordController: _passwordController),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Expanded(child: _buildLoginButton(s)),
                                        SizedBox(width: 12.w),
                                        _buildBiometricButton(isDarkMode),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    OptionsSection(),

                                    SizedBox(height: 16.h),
                                    FooterSection(isDarkMode: isDarkMode, onFooterLinkTap: _handleFooterLinkTap),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // شاشة التحميل المحسّنة
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), backgroundBlendMode: BlendMode.darken),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(32.w),
                          decoration: BoxDecoration(
                            color: isDarkMode ? AppColors.darkSurface : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(24.r),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20.r, offset: Offset(0, 10.h))],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LoadingIndicator(size: 80.w, color: Theme.of(context).colorScheme.primary),
                              SizedBox(height: 16.h),
                              Text(
                                'جاري تسجيل الدخول...',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showMoreOptionsDialog() {
    final s = AppStrings.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          title: Row(
            children: [
              Icon(Icons.more_horiz, color: Theme.of(context).colorScheme.primary),
              SizedBox(width: 12.w),
              Text(s.moreOptionsTitle),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
                title: Text(s.changeLanguage),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(context: context, builder: (context) => const LanguageDialog());
                },
              ),
              ListTile(
                leading: Icon(Icons.security, color: Theme.of(context).colorScheme.primary),
                title: Text(s.securitySettings),
                onTap: () {
                  Navigator.pop(context);
                  _showSecurityDialog();
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                title: Text(s.aboutApp),
                onTap: () {
                  Navigator.pop(context);
                  _showAboutDialog();
                },
              ),
            ],
          ),
          actions: [GestureDetector(onTap: () => Navigator.of(context).pop(), child: Text(s.close))],
        );
      },
    );
  }

  void _showSecurityDialog() {
    //     // تنفيذ إعدادات الأمان
  }

  void _showAboutDialog() {
    final s = AppStrings.of(context);
    showAboutDialog(
      context: context,
      applicationName: s.appTitle,
      applicationVersion: '1.6.344',
      applicationIcon: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(12.r)),
        child: Center(
          child: Text(
            'K',
            style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      children: [
        Text(s.aboutBankLine1),
        SizedBox(height: 10.h),
        Text(s.aboutBankLine2),
      ],
    );
  }

  // وظائف إضافية
  void _handleFooterLinkTap(String linkText) {
    final s = AppStrings.of(context);
    if (linkText == s.supportComputer) {
      _showSupportDialog();
    } else if (linkText == s.whatsapp) {
      _showMoreOptionsDialog();
    } else if (linkText == s.rateApp) {
      _rateApp();
    }
  }

  void _showSupportDialog() {
    final s = AppStrings.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          title: Row(
            children: [
              Icon(Icons.support_agent, color: Theme.of(context).colorScheme.primary),
              SizedBox(width: 12.w),
              Text(s.supportTitle),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.contactMethodsText),
              SizedBox(height: 15.h),
              _buildSupportOption(Icons.phone, s.phoneLabel),
              _buildSupportOption(Icons.email, s.emailLabel),
              _buildSupportOption(Icons.chat, s.chatLabel),
            ],
          ),
          actions: [GestureDetector(onTap: () => Navigator.of(context).pop(), child: Text(s.close))],
        );
      },
    );
  }

  Widget _buildLoginButton(AppStrings s) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        gradient: AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(color: AppColors.primaryColor.withOpacity(0.4), blurRadius: 20.r, offset: Offset(0, 10.h), spreadRadius: 2.r),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _login,
          borderRadius: BorderRadius.circular(24.r),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            alignment: Alignment.center,
            child: _isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(strokeWidth: 2.w, valueColor: const AlwaysStoppedAnimation<Color>(Colors.white)),
                  )
                : Text(s.loginButton, style: AppTextStyles.buttonText),
          ),
        ),
      ),
    );
  }

  Widget _buildBiometricButton(bool isDarkMode) {
    return SizedBox(
      height: 56.h,
      width: 56.w,
      child: BiometricSection(isDarkMode: isDarkMode, onTap: _loginWithBiometric),
    );
  }

  Widget _buildSupportOption(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: Theme.of(context).colorScheme.primary),
          SizedBox(width: 10.w),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }

  void _rateApp() {
    final s = AppStrings.of(context);
    // تنفيذ تقييم التطبيق
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.rateAppSnackbar),
        backgroundColor: AppColors.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
