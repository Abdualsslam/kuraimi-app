import 'package:flutter/material.dart';
import 'package:kuraimi/widgets/bottom_navigation.dart';
import 'package:kuraimi/widgets/theme_switch_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import '../../providers/theme_cubit.dart'; // This now refers to ThemeCubit
import 'package:go_router/go_router.dart';
import '../../constants/app_strings.dart';
import 'package:kuraimi/widgets/language_dialog.dart'; // Import LanguageDialog

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.settings)),
      body: ListView(
        children: [
          ListTile(
            title: Text(s.theme),
            trailing: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return const ThemeSwitchWidget();
              },
            ),
          ),
          ListTile(
            title: Text(s.language),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(context: context, builder: (context) => LanguageDialog());
            },
          ),
          ListTile(
            title: Text(s.aboutUs),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to an About Us screen or show a dialog
              // For now, let's just show a simple snackbar
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.aboutUsContent)));
            },
          ),
          // Add other settings options here
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentTab: 4, // Settings is index 4
        onTabSelected: (index) {
          switch (index) {
            case 0: // Profile
              context.go('/profile');
              break;
            case 1: // Transactions
              context.go('/transactions');
              break;
            case 2: // Home (Logo)
              context.go('/home');
              break;
            case 3: // Notifications (using navServices)
              context.go('/services');
              break;
            case 4: // Settings
              context.go('/settings');
              break;
          }
        },
      ),
    );
  }
}
