import '../entities/batch_entity.dart';

abstract class BatchRepository {
  Future<BatchEntity?> getCurrentBatch(String unionId);
  Future<List<BatchEntity>> getBatchHistory(String unionId);
  Stream<BatchEntity> watchBatchStatus(String batchId);
}
