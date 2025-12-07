import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kuraimi/constants/app_strings.dart';
import 'package:kuraimi/constants/assets.dart';
import 'package:kuraimi/widgets/bottom_navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  bool _hideAccountNumber = true;
  bool _hidePhoneNumber = false;

  late AnimationController _profileCardController;
  late Animation<Offset> _profileCardAnimation;
  late Animation<double> _profileCardFadeAnimation;

  late AnimationController _accountInfoCardController;
  late Animation<Offset> _accountInfoCardAnimation;
  late Animation<double> _accountInfoCardFadeAnimation;

  late AnimationController _contactInfoCardController;
  late Animation<Offset> _contactInfoCardAnimation;
  late Animation<double> _contactInfoCardFadeAnimation;

  late AnimationController _quickServicesCardController;
  late Animation<Offset> _quickServicesCardAnimation;
  late Animation<double> _quickServicesCardFadeAnimation;

  @override
  void initState() {
    super.initState();

    _profileCardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _profileCardAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _profileCardController, curve: Curves.easeOut));
    _profileCardFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _profileCardController, curve: Curves.easeOut));

    _accountInfoCardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _accountInfoCardAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _accountInfoCardController, curve: Curves.easeOut));
    _accountInfoCardFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _accountInfoCardController, curve: Curves.easeOut));

    _contactInfoCardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _contactInfoCardAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _contactInfoCardController, curve: Curves.easeOut));
    _contactInfoCardFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _contactInfoCardController, curve: Curves.easeOut));

    _quickServicesCardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _quickServicesCardAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _quickServicesCardController, curve: Curves.easeOut));
    _quickServicesCardFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _quickServicesCardController, curve: Curves.easeOut));

    _playAnimations();
  }

  Future<void> _playAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _profileCardController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    _accountInfoCardController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    _contactInfoCardController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    _quickServicesCardController.forward();
  }

  @override
  void dispose() {
    _profileCardController.dispose();
    _accountInfoCardController.dispose();
    _contactInfoCardController.dispose();
    _quickServicesCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final s = AppStrings.of(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CustomBottomBar(
        currentTab: 0,
        onTabSelected: (index) {
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
        },
      ),
      body: Container(
        color: theme.scaffoldBackgroundColor,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  floating: true,
                  pinned: false,
                  title: Text(s.personalInfo, style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
                  centerTitle: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        FadeTransition(
                          opacity: _profileCardFadeAnimation,
                          child: SlideTransition(position: _profileCardAnimation, child: _buildProfileCard(context, colorScheme, s)),
                        ),
                        const SizedBox(height: 20),
                        FadeTransition(
                          opacity: _accountInfoCardFadeAnimation,
                          child: SlideTransition(
                            position: _accountInfoCardAnimation,
                            child: _buildAccountInfoCard(context, colorScheme, s),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeTransition(
                          opacity: _contactInfoCardFadeAnimation,
                          child: SlideTransition(
                            position: _contactInfoCardAnimation,
                            child: _buildContactInfoCard(context, colorScheme, s),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeTransition(
                          opacity: _quickServicesCardFadeAnimation,
                          child: SlideTransition(
                            position: _quickServicesCardAnimation,
                            child: _buildQuickServicesCard(context, colorScheme, s),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, ColorScheme colorScheme, AppStrings s) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [colorScheme.primary, colorScheme.secondary]),
                  boxShadow: [BoxShadow(color: colorScheme.primary.withOpacity(0.3), blurRadius: 20, spreadRadius: 2)],
                ),
                child: ClipOval(child: Image.asset(Assets.iconProfile, fit: BoxFit.cover)),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                ),
                child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('عبد السلام معاد', style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colorScheme.secondary.withOpacity(0.5)),
            ),
            child: Text(s.goldenMember, style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoCard(BuildContext context, ColorScheme colorScheme, AppStrings s) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.accountInfo, style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.account_balance_wallet,
            title: s.accountNumber,
            value: _hideAccountNumber ? '****1234' : '3002140108',
            showToggle: true,
            isHidden: _hideAccountNumber,
            onToggle: () => setState(() => _hideAccountNumber = !_hideAccountNumber),
            color: colorScheme.primary,
          ),
          _buildInfoRow(icon: Icons.credit_card, title: s.cardNumber, value: '**** **** **** 1234', color: colorScheme.secondary),
          _buildInfoRow(icon: Icons.verified_user, title: s.accountStatus, value: s.accountActive, color: Colors.green),
          _buildInfoRow(icon: Icons.date_range, title: s.joiningDate, value: '15 يناير 2020', color: colorScheme.primary),
        ],
      ),
    );
  }

  Widget _buildContactInfoCard(BuildContext context, ColorScheme colorScheme, AppStrings s) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.contactInfo, style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.phone,
            title: s.phoneNumber,
            value: _hidePhoneNumber ? '****567890' : '777567890',
            showToggle: true,
            isHidden: _hidePhoneNumber,
            onToggle: () => setState(() => _hidePhoneNumber = !_hidePhoneNumber),
            color: colorScheme.secondary,
          ),
          _buildInfoRow(icon: Icons.email, title: s.email, value: 'abdulsalam@email.com', color: colorScheme.primary),
          _buildInfoRow(icon: Icons.location_on, title: s.address, value: 'صنعاء، اليمن', color: colorScheme.secondary),
        ],
      ),
    );
  }

  Widget _buildQuickServicesCard(BuildContext context, ColorScheme colorScheme, AppStrings s) {
    final theme = Theme.of(context);
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.quickServices, style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickServiceButton(
                  icon: Icons.qr_code,
                  title: s.qrCode,
                  color: colorScheme.primary,
                  onTap: () => _showQRDialog(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickServiceButton(
                  icon: Icons.receipt_long,
                  title: s.accountStatement,
                  color: colorScheme.secondary,
                  onTap: () => _downloadStatement(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickServiceButton(
                  icon: Icons.support_agent,
                  title: s.technicalSupport,
                  color: colorScheme.secondary,
                  onTap: () => _contactSupport(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickServiceButton(
                  icon: Icons.security,
                  title: s.security,
                  color: colorScheme.primary,
                  onTap: () => _securitySettings(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    bool showToggle = false,
    bool isHidden = false,
    VoidCallback? onToggle,
  }) {
    final theme = Theme.of(context); // Define theme here
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface),
                ),
              ],
            ),
          ),
          if (showToggle)
            IconButton(
              onPressed: onToggle,
              icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility, color: theme.colorScheme.onSurface.withOpacity(0.7), size: 20),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickServiceButton({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    final theme = Theme.of(context); // Define theme here
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.labelMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showQRDialog() {
    // عرض رمز QR
  }

  void _downloadStatement() {
    // تحميل كشف الحساب
  }

  void _contactSupport() {
    // الاتصال بالدعم الفني
  }

  void _securitySettings() {
    // إعدادات الأمان
  }
}

// Container زجاجي قابل للإعادة استخدام
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const GlassContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.cardTheme.color, // Use theme's card color
      child: Padding(padding: padding ?? const EdgeInsets.all(20), child: child),
    );
  }
}
