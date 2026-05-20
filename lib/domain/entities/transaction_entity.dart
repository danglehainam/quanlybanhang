class TransactionEntity {
  final int id;
  final int storeId;
  final int createdBy;
  final int type; // 0: income, 1: expense
  final int amount;
  final String note;
  final DateTime createdAt;

  const TransactionEntity({
    required this.id,
    required this.storeId,
    required this.createdBy,
    required this.type,
    required this.amount,
    required this.note,
    required this.createdAt,
  });
}
