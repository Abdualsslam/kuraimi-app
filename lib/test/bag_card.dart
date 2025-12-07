import 'package:flutter/material.dart';
import 'package:kuraimi/models/transaction.dart';
import 'package:kuraimi/test/transaction_card.dart';

// // بطاقة معاملة محسنة
// class EnhancedTransactionCard extends StatefulWidget {
//   final Transaction transaction;
//   final VoidCallback? onTap;
//   final bool showDetails;

//   const EnhancedTransactionCard({super.key, required this.transaction, this.onTap, this.showDetails = false});

//   @override
//   State<EnhancedTransactionCard> createState() => _EnhancedTransactionCardState();
// }

// class _EnhancedTransactionCardState extends State<EnhancedTransactionCard> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   bool _isPressed = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Color _getTypeColor() {
//     switch (widget.transaction.type) {
//       case TransactionType.income:
//         return Colors.green;
//       case TransactionType.expense:
//         return Colors.red;
//       case TransactionType.transfer:
//         return Colors.blue;
//     }
//   }

//   IconData _getTypeIcon() {
//     switch (widget.transaction.type) {
//       case TransactionType.income:
//         return Icons.arrow_downward_rounded;
//       case TransactionType.expense:
//         return Icons.arrow_upward_rounded;
//       case TransactionType.transfer:
//         return Icons.swap_horiz_rounded;
//     }
//   }

//   String _getStatusText() {
//     switch (widget.transaction.status) {
//       case TransactionStatus.completed:
//         return 'مكتملة';
//       case TransactionStatus.pending:
//         return 'قيد الانتظار';
//       case TransactionStatus.failed:
//         return 'فاشلة';
//     }
//   }

//   Color _getStatusColor() {
//     switch (widget.transaction.status) {
//       case TransactionStatus.completed:
//         return Colors.green;
//       case TransactionStatus.pending:
//         return Colors.orange;
//       case TransactionStatus.failed:
//         return Colors.red;
//     }
//   }

//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = DateTime(now.year, now.month, now.day - 1);
//     final transactionDate = DateTime(date.year, date.month, date.day);

//     if (transactionDate == today) {
//       return 'اليوم، ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
//     } else if (transactionDate == yesterday) {
//       return 'أمس، ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
//     } else {
//       return '${date.day}/${date.month}/${date.year}';
//     }
//   }

//   String _formatAmount(double amount) {
//     final abs = amount.abs();
//     final sign = amount >= 0 ? '+' : '-';
//     return '$sign ${abs.toStringAsFixed(2)}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final typeColor = _getTypeColor();
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return GestureDetector(
//       onTapDown: (_) {
//         setState(() => _isPressed = true);
//         _controller.forward();
//       },
//       onTapUp: (_) {
//         setState(() => _isPressed = false);
//         _controller.reverse();
//         if (widget.onTap != null) widget.onTap!();
//       },
//       onTapCancel: () {
//         setState(() => _isPressed = false);
//         _controller.reverse();
//       },
//       child: AnimatedScale(
//         scale: _isPressed ? 0.98 : 1.0,
//         duration: const Duration(milliseconds: 150),
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           decoration: BoxDecoration(
//             color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.1)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
//                 blurRadius: _isPressed ? 5 : 10,
//                 offset: Offset(0, _isPressed ? 2 : 4),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Stack(
//               children: [
//                 // خط جانبي ملون
//                 Positioned(
//                   right: 0,
//                   top: 0,
//                   bottom: 0,
//                   child: Container(
//                     width: 4,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [typeColor, typeColor.withOpacity(0.5)],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // المحتوى الرئيسي
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           // أيقونة المعاملة
//                           Container(
//                             width: 48,
//                             height: 48,
//                             decoration: BoxDecoration(color: typeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
//                             child: Icon(_getTypeIcon(), color: typeColor, size: 24),
//                           ),

//                           const SizedBox(width: 16),

//                           // تفاصيل المعاملة
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         widget.transaction.title,
//                                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                     if (widget.transaction.status != TransactionStatus.completed)
//                                       Container(
//                                         margin: const EdgeInsets.only(right: 8),
//                                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                                         decoration: BoxDecoration(
//                                           color: _getStatusColor().withOpacity(0.1),
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                         child: Text(
//                                           _getStatusText(),
//                                           style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _getStatusColor()),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   widget.transaction.description,
//                                   style: Theme.of(
//                                     context,
//                                   ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.access_time, size: 12, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
//                                     const SizedBox(width: 4),
//                                     Text(
//                                       _formatDate(widget.transaction.date),
//                                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                         color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
//                                         fontSize: 11,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(width: 12),

//                           // المبلغ
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 _formatAmount(widget.transaction.amount),
//                                 style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: typeColor),
//                               ),
//                               const SizedBox(height: 2),
//                               Text(
//                                 'ريال',
//                                 style: Theme.of(
//                                   context,
//                                 ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       // تفاصيل إضافية (اختياري)
//                       if (widget.showDetails && widget.transaction.recipientName != null) ...[
//                         const SizedBox(height: 12),
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.person_outline, size: 16, color: Theme.of(context).colorScheme.primary),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'إلى: ${widget.transaction.recipientName}',
//                                 style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// قائمة المعاملات مع Shimmer Loading
class TransactionsList extends StatelessWidget {
  final List<Transaction>? transactions;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const TransactionsList({super.key, this.transactions, this.isLoading = false, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final List<Transaction> _recentTransactions = [
      Transaction(
        id: '1',
        title: 'تحويل إلى أحمد',
        description: 'تحويل فوري',
        amount: -500.00,
        date: DateTime.now(),
        type: TransactionType.transfer,
      ),
      Transaction(
        id: '2',
        title: 'استلام من محمد',
        description: 'تحويل وارد',
        amount: 1200.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        type: TransactionType.income,
      ),
    ];
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
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _recentTransactions.length,
        itemBuilder: (context, index) {
          return EnhancedTransactionCard(
            transaction: _recentTransactions[index],
            onTap: () {
              print('تم الضغط على المعاملة ${_recentTransactions[index].title}');
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 100,
                        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
          Text(
            'لا توجد معاملات',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          ),
          const SizedBox(height: 8),
          Text(
            'ستظهر معاملاتك هنا',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionDetailsSheet(transaction: transaction),
    );
  }
}

// ورقة تفاصيل المعاملة
class TransactionDetailsSheet extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsSheet({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان
                Text('تفاصيل المعاملة', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),

                // المبلغ
                Center(
                  child: Column(
                    children: [
                      Text(
                        '${transaction.amount.abs().toStringAsFixed(2)} ريال',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: transaction.amount >= 0 ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, size: 16, color: Colors.green),
                            const SizedBox(width: 6),
                            Text(
                              'مكتملة',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // التفاصيل
                _buildDetailRow(context, Icons.description_outlined, 'الوصف', transaction.description),
                const SizedBox(height: 16),
                _buildDetailRow(
                  context,
                  Icons.calendar_today_outlined,
                  'التاريخ',
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  context,
                  Icons.access_time,
                  'الوقت',
                  '${transaction.date.hour}:${transaction.date.minute.toString().padLeft(2, '0')}',
                ),
                const SizedBox(height: 16),
                _buildDetailRow(context, Icons.tag, 'رقم المعاملة', '#${transaction.id}'),

                const SizedBox(height: 32),

                // أزرار الإجراءات
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // مشاركة
                        },
                        icon: const Icon(Icons.share_outlined),
                        label: const Text('مشاركة'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // طباعة أو حفظ
                        },
                        icon: const Icon(Icons.download_outlined),
                        label: const Text('حفظ'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              ),
              const SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

// مثال على الاستخدام
class TransactionsScreenExample extends StatefulWidget {
  const TransactionsScreenExample({super.key});

  @override
  State<TransactionsScreenExample> createState() => _TransactionsScreenExampleState();
}

class _TransactionsScreenExampleState extends State<TransactionsScreenExample> {
  bool _isLoading = true;
  List<Transaction>? _transactions;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);

    // محاكاة تحميل البيانات
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _transactions = [
        Transaction(
          id: '12345',
          title: 'تحويل إلى أحمد',
          description: 'تحويل فوري',
          amount: -500.00,
          date: DateTime.now(),
          type: TransactionType.transfer,
          recipientName: 'أحمد محمد',
        ),
        Transaction(
          id: '12346',
          title: 'استلام من محمد',
          description: 'تحويل وارد',
          amount: 1200.00,
          date: DateTime.now().subtract(const Duration(days: 1)),
          type: TransactionType.income,
          recipientName: 'محمد علي',
        ),
        Transaction(
          id: '12347',
          title: 'دفع فاتورة كهرباء',
          description: 'فاتورة شهر سبتمبر',
          amount: -250.00,
          date: DateTime.now().subtract(const Duration(days: 5)),
          type: TransactionType.expense,
          status: TransactionStatus.completed,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المعاملات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // فلترة
            },
          ),
        ],
      ),
      body: TransactionsList(transactions: _transactions, isLoading: _isLoading, onRefresh: _loadTransactions),
    );
  }
}
