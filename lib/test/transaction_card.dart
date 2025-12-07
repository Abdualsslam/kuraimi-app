import 'package:flutter/material.dart';
import '../models/transaction.dart';

class EnhancedTransactionCard extends StatefulWidget {
  final Transaction transaction;
  final VoidCallback? onTap;
  final bool showDetails;

  const EnhancedTransactionCard({super.key, required this.transaction, this.onTap, this.showDetails = false});

  @override
  State<EnhancedTransactionCard> createState() => _EnhancedTransactionCardState();
}

class _EnhancedTransactionCardState extends State<EnhancedTransactionCard> {
  bool _isPressed = false;

  Color _getTypeColor() {
    switch (widget.transaction.type) {
      case TransactionType.income:
        return Colors.green;
      case TransactionType.expense:
        return Colors.red;
      case TransactionType.transfer:
        return Colors.blue;
    }
  }

  IconData _getTypeIcon() {
    switch (widget.transaction.type) {
      case TransactionType.income:
        return Icons.arrow_downward_rounded;
      case TransactionType.expense:
        return Icons.arrow_upward_rounded;
      case TransactionType.transfer:
        return Icons.swap_horiz_rounded;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'اليوم، ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (transactionDate == yesterday) {
      return 'أمس، ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatAmount(double amount) {
    final abs = amount.abs();
    final sign = amount >= 0 ? '+' : '-';
    return '$sign ${abs.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        if (widget.onTap != null) widget.onTap!();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                blurRadius: _isPressed ? 5 : 10,
                offset: Offset(0, _isPressed ? 2 : 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [typeColor, typeColor.withOpacity(0.5)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: typeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                      child: Icon(_getTypeIcon(), color: typeColor, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.transaction.title,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.transaction.description,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                              const SizedBox(width: 4),
                              Text(
                                _formatDate(widget.transaction.date),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatAmount(widget.transaction.amount),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: typeColor),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ريال',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget لقائمة المعاملات مع Loading
class TransactionsList extends StatelessWidget {
  final List<Transaction>? transactions;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const TransactionsList({super.key, this.transactions, this.isLoading = false, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildShimmerLoading(context);
    }

    if (transactions == null || transactions!.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (onRefresh != null) onRefresh!();
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: transactions!.length,
        itemBuilder: (context, index) {
          return EnhancedTransactionCard(
            transaction: transactions![index],
            onTap: () {
              // يمكنك عرض التفاصيل هنا
            },
          );
        },
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 80,
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(16)),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text('لا توجد معاملات', style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
