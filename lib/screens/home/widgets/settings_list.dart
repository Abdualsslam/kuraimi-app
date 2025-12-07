import 'package:flutter/material.dart';
import '../../../constants/app_strings.dart';

class SettingsList extends StatelessWidget {
  final Function(String) onSettingTap;

  const SettingsList({super.key, required this.onSettingTap});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final settings = [
      {'title': s.stProfile, 'icon': Icons.person_outline, 'action': 'profile'},
      {'title': s.stSecurity, 'icon': Icons.security_outlined, 'action': 'security'},
      {'title': s.stNotifications, 'icon': Icons.notifications_outlined, 'action': 'notifications'},
      {'title': s.stLanguage, 'icon': Icons.language_outlined, 'action': 'language'},
      {'title': s.stSupport, 'icon': Icons.help_outline, 'action': 'support'},
      {'title': s.stAbout, 'icon': Icons.info_outline, 'action': 'about'},
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: settings.map((setting) {
          return ListTile(
            leading: Icon(setting['icon'] as IconData, color: Theme.of(context).colorScheme.primary),
            title: Text(setting['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => onSettingTap(setting['title'] as String),
          );
        }).toList(),
      ),
    );
  }
}
