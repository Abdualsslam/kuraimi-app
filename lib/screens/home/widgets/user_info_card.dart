import 'package:flutter/material.dart';
import 'package:kuraimi/themes/app_colors.dart';
import 'package:kuraimi/themes/app_theme.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/assets.dart';

class UserInfoCard extends StatelessWidget {
  final Map<String, dynamic> userData;
  final bool isDarkMode;

  const UserInfoCard({super.key, required this.userData, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: AppTheme.getCardDecoration(isDarkMode, borderRadius: 20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              child: ClipOval(child: Image.asset(Assets.iconProfile, fit: BoxFit.cover)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userData['name'] ?? '', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    '${s.accountNumberLabel} ${userData['accountNumber'] ?? ''}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.getTextSecondaryColor(isDarkMode)),
                  ),
                  Text(
                    userData['accountType'] ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // إظهار QR Code وهمي
              },
              icon: const Icon(Icons.qr_code),
              tooltip: s.qrCode,
            ),
          ],
        ),
      ),
    );
  }
}
