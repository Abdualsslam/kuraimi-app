import 'package:flutter/material.dart';
import '../../../constants/app_strings.dart';

class QuickActions extends StatelessWidget {
  final Function(String) onActionTap;
  final bool isDarkMode;

  const QuickActions({super.key, required this.onActionTap, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final actions = [
      {'title': s.quickInstantTransfer, 'icon': Icons.flash_on_outlined, 'color': Colors.orange, 'action': s.quickInstantTransfer},
      {'title': s.quickBillPayment, 'icon': Icons.receipt_long_outlined, 'color': Colors.green, 'action': s.quickBillPayment},
      {'title': s.quickTopUp, 'icon': Icons.phone_android_outlined, 'color': Colors.blue, 'action': s.quickTopUp},
      {'title': s.quickStatement, 'icon': Icons.description_outlined, 'color': Colors.purple, 'action': s.quickStatement},
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.quickActionsTitle, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 3,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                final action = actions[index];
                return _buildActionItem(
                  context,
                  action['title'] as String,
                  action['icon'] as IconData,
                  action['color'] as Color,
                  () => onActionTap(action['action'] as String),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: color),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
