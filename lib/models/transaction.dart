class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionStatus status;
  final String? recipientName;
  final String? categoryIcon;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    this.status = TransactionStatus.completed,
    this.recipientName,
    this.categoryIcon,
  });
}

enum TransactionType {
  income, // دخل
  expense, // مصروف
  transfer, // تحويل
}

enum TransactionStatus {
  completed, // مكتملة
  pending, // قيد الانتظار
  failed, // فاشلة
}
