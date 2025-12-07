import 'package:flutter/material.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_theme.dart';
import '../../../constants/app_strings.dart';

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;
  final bool isLimited;
  final VoidCallback? onSeeAll;
  final bool isDarkMode;

  const TransactionList({super.key, required this.transactions, this.isLimited = true, this.onSeeAll, this.isDarkMode = false});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final displayTransactions = isLimited ? transactions.take(3).toList() : transactions;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isLimited ? s.recentTransactions : s.allTransactions,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (isLimited && onSeeAll != null) GestureDetector(onTap: onSeeAll, child: Text(s.seeAll)),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayTransactions.length,
              itemBuilder: (context, index) {
                final transaction = displayTransactions[index];
                return _buildTransactionItem(context, transaction);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Map<String, dynamic> transaction) {
    // transaction: {'title': ..., 'amount': ..., 'date': ..., 'type': ...}
    final s = AppStrings.of(context);
    final isCredit = (transaction['type'] ?? '').toString().toLowerCase() == 'credit';
    final amount = transaction['amount'] ?? 0;
    final title = transaction['title'] ?? s.transaction;
    final date = transaction['date'] ?? '';
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isCredit ? AppColors.successColor.withValues(alpha: 0.12) : AppColors.errorColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCredit ? Icons.arrow_downward : Icons.arrow_upward,
            color: isCredit ? AppColors.successColor : AppColors.errorColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(date, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.getTextSecondaryColor(isDarkMode))),
            ],
          ),
        ),
        Text(
          (isCredit ? '+' : '-') + amount.toString(),
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: isCredit ? AppColors.successColor : AppColors.errorColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
