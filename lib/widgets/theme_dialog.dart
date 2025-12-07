import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuraimi/providers/theme_cubit.dart'; // Import flutter_bloc
import 'package:kuraimi/constants/app_strings.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(context: context, builder: (BuildContext context) => const ThemeDialog());
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      // Use BlocBuilder
      builder: (context, themeState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.palette, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Text(s.themeTitle),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ThemeOption(
                title: s.themeLightTitle,
                subtitle: s.themeLightSubtitle,
                icon: Icons.light_mode,
                isSelected: themeState.themeMode == ThemeMode.light, // Access themeMode from ThemeState
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(ThemeMode.light);
                  Navigator.of(context).pop();
                }, // Call setThemeMode on ThemeCubit
              ),
              const SizedBox(height: 8),
              _ThemeOption(
                title: s.themeDarkTitle,
                subtitle: s.themeDarkSubtitle,
                icon: Icons.dark_mode,
                isSelected: themeState.themeMode == ThemeMode.dark, // Access themeMode from ThemeState
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(ThemeMode.dark);
                  Navigator.of(context).pop();
                }, // Call setThemeMode on ThemeCubit
              ),
              const SizedBox(height: 8),
              _ThemeOption(
                title: s.themeSystemTitle,
                subtitle: s.themeSystemSubtitle,
                icon: Icons.settings_system_daydream,
                isSelected: themeState.themeMode == ThemeMode.system, // Access themeMode from ThemeState
                onTap: () {
                  context.read<ThemeCubit>().setThemeMode(ThemeMode.system);
                  Navigator.of(context).pop();
                }, // Call setThemeMode on ThemeCubit
              ),
            ],
          ),
          actions: [GestureDetector(onTap: () => Navigator.of(context).pop(), child: Text(s.close))],
        );
      },
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({required this.title, required this.subtitle, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor, width: 2),
          color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected ? Theme.of(context).colorScheme.primary : null,
                      fontWeight: isSelected ? FontWeight.w600 : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
