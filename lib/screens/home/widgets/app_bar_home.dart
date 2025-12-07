import 'package:flutter/material.dart';
import 'package:kuraimi/widgets/theme_switch_widget.dart';
import '../../../constants/app_strings.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Map<String, dynamic>? userData;
  final VoidCallback onNotifications;
  final VoidCallback onLogout;

  const HomeAppBar({super.key, required this.userData, required this.onNotifications, required this.onLogout}); // Removed themeProvider

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleSpacing: 30.0, // Added to move the title further to the left
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${s.hello} ${userData?['name'] ?? ''}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            s.welcomeToBank,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7), fontSize: 12),
          ),
        ],
      ),
      actions: [
        SizedBox(width: 8),
        ThemeSwitchWidget(),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onNotifications,
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ),
        IconButton(onPressed: onLogout, icon: const Icon(Icons.logout)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
