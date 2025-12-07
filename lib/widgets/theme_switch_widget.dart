import 'package:flutter/material.dart';
import 'package:kuraimi/widgets/theme_dialog.dart'; // Import ThemeDialog

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ThemeDialog();
          },
        );
      },
      child: Icon(
        Icons.brightness_6_rounded,
        color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }
}
