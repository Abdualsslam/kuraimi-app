import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import '../constants/app_strings.dart';
import '../providers/locale_cubit.dart'; // Updated import

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(s.changeLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(s.arabicLanguage),
            onTap: () {
              Navigator.of(context).pop();
              context.read<LocaleCubit>().setLocale(const Locale('ar')); // Call setLocale on LocaleCubit
            },
          ),
          ListTile(
            title: Text(s.englishLanguage),
            onTap: () {
              Navigator.of(context).pop();
              context.read<LocaleCubit>().setLocale(const Locale('en')); // Call setLocale on LocaleCubit
            },
          ),
        ],
      ),
      actions: [GestureDetector(onTap: () => Navigator.of(context).pop(), child: Text(s.close))],
    );
  }
}
