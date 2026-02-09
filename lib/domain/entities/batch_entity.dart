import '../../core/enums.dart';

class BatchEntity {
  const BatchEntity({
    required this.id,
    required this.thanaId,
    required this.unionId, // Scope of the batch
    required this.startTime,
    required this.endTime,
    required this.targetQuantity,
    required this.currentQuantity,
    required this.status,
  });

  final String id;
  final String thanaId;
  final String unionId;
  final DateTime startTime;
  final DateTime endTime;
  final int targetQuantity;
  final int currentQuantity;
  final BatchStatus status;

  bool get isFulfilled => currentQuantity >= targetQuantity;
  Duration get timeRemaining => endTime.difference(DateTime.now());
}
