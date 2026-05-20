import '../../domain/entities/transaction_entity.dart';
import '../datasources/local/app_database.dart'; // To get TransactionDriftModel

class TransactionModel {
  final int id;
  final int storeId;
  final int createdBy;
  final int type;
  final int amount;
  final String note;
  final DateTime createdAt;

  const TransactionModel({
    required this.id,
    required this.storeId,
    required this.createdBy,
    required this.type,
    required this.amount,
    required this.note,
    required this.createdAt,
  });

  // Mapper: From Drift
  factory TransactionModel.fromDrift(TransactionDriftModel driftModel) {
    return TransactionModel(
      id: driftModel.id,
      storeId: driftModel.storeId,
      createdBy: driftModel.createdBy,
      type: driftModel.type,
      amount: driftModel.amount,
      note: driftModel.note,
      createdAt: DateTime.fromMillisecondsSinceEpoch(driftModel.createdAt),
    );
  }

  // Mapper: From JSON
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as int,
      storeId: json['store_id'] as int,
      createdBy: json['created_by'] as int,
      type: json['type'] as int,
      amount: json['amount'] as int,
      note: json['note'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
    );
  }

  // Mapper: To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_id': storeId,
      'created_by': createdBy,
      'type': type,
      'amount': amount,
      'note': note,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  // Mapper: To Entity
  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      storeId: storeId,
      createdBy: createdBy,
      type: type,
      amount: amount,
      note: note,
      createdAt: createdAt,
    );
  }

  // Mapper: From Entity
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      storeId: entity.storeId,
      createdBy: entity.createdBy,
      type: entity.type,
      amount: entity.amount,
      note: entity.note,
      createdAt: entity.createdAt,
    );
  }
}
