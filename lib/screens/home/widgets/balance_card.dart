import 'package:flutter/material.dart';
import 'package:kuraimi/themes/app_gradients.dart';
import '../../../constants/app_strings.dart';

class BalanceCard extends StatelessWidget {
  final Map<String, dynamic> userData;
  final bool isDarkMode;
  final VoidCallback onTransfer;
  final VoidCallback onDeposit;

  const BalanceCard({super.key, required this.userData, required this.isDarkMode, required this.onTransfer, required this.onDeposit});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(gradient: AppGradients.buttonGradient(isDarkMode), borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    s.availableBalance,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.visibility_outlined, color: Colors.white.withValues(alpha: 0.8)),
              ],
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                '${_formatCurrency(userData['balance'] ?? 0.0)} ${s.currencySuffix}',
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildActionButton(s.transfer, Icons.send_outlined, onTransfer)),
                const SizedBox(width: 12),
                Expanded(child: _buildActionButton(s.deposit, Icons.add_outlined, onDeposit)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
