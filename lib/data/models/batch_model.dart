import '../../domain/entities/batch_entity.dart';
import '../../core/enums.dart';

class BatchModel extends BatchEntity {
  const BatchModel({
    required super.id,
    required super.thanaId,
    required super.unionId, // Note: Schema has thana_id, but our entity has unionId too. We'll use thana_id as primary grouping for now based on schema.
    required super.startTime,
    required super.endTime,
    required super.targetQuantity,
    required super.currentQuantity,
    required super.status,
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) {
    return BatchModel(
      id: json['id'] as String,
      thanaId: json['thana_id'] as String? ?? '',
      unionId:
          json['union_id'] as String? ??
          '', // Schema might need this if batches are union specific. Schema only has thana_id. Using placeholder.
      startTime: DateTime.parse(json['start_at'] as String),
      endTime: DateTime.parse(json['end_at'] as String),
      targetQuantity: (json['min_orders'] as num).toInt(),
      currentQuantity:
          0, // Need to count orders to get this, not in batch table directly usually.
      status: _parseStatus(json['status'] as String),
    );
  }

  static BatchStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'CLOSED':
        return BatchStatus.closed;
      case 'PROCESSING':
        return BatchStatus.processing;
      case 'COMPLETED':
        return BatchStatus.completed;
      default:
        return BatchStatus.open;
    }
  }
}
