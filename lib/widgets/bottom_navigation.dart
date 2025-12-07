import 'package:flutter/material.dart';
import 'package:kuraimi/constants/assets.dart';
import 'package:kuraimi/widgets/logo.dart';
import '../../../constants/app_strings.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentTab;
  final ValueChanged<int> onTabSelected;

  const CustomBottomBar({super.key, required this.currentTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final s = AppStrings.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          size: Size(size.width, 80),
          painter: BNBCustomPainter(isDark: isDark),
        ),
        Center(
          heightFactor: 0.6,
          child: GestureDetector(
            onTap: () => onTabSelected(2), // Home is index 2
            child: const LogoFAB(size: 60, haloSize: 50, imagePath: Assets.iconLogo, active: true),
          ),
        ),
        SizedBox(
          width: size.width,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavItem(icon: Icons.person_outline, label: s.navProfile, active: currentTab == 0, onTap: () => onTabSelected(0)),
              NavItem(icon: Icons.history_outlined, label: s.navTransactions, active: currentTab == 1, onTap: () => onTabSelected(1)),
              Container(width: size.width * .20), // Space for the FAB
              NavItem(
                icon: Icons.notifications_none,
                label: s.navServices,
                active: currentTab == 3,
                onTap: () => onTabSelected(3),
              ), // Using navServices for notifications
              NavItem(icon: Icons.settings_outlined, label: s.navSettings, active: currentTab == 4, onTap: () => onTabSelected(4)),
            ],
          ),
        ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const NavItem({super.key, required this.icon, required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: active ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          Text(
            label,
            style: TextStyle(
              color: active ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  final bool isDark;

  BNBCustomPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isDark ? const Color(0xFF1A1C28) : Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * .20, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .40, 0, size.width * .40, 20);
    path.arcToPoint(Offset(size.width * .60, 20), radius: const Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * .60, 0, size.width * .65, 0);
    path.quadraticBezierTo(size.width * .80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
