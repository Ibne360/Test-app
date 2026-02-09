import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/batch_repository.dart';
import '../../domain/entities/batch_entity.dart';
import '../models/batch_model.dart';

class BatchRepositoryImpl implements BatchRepository {
  final SupabaseClient _supabase;

  BatchRepositoryImpl(this._supabase);

  @override
  Future<BatchEntity?> getCurrentBatch(String unionId) async {
    // Logic: Find open batch for the thana related to this union?
    // Schema only has thana_id for batch. So we might need to find thana for the union first or assume caller passes thanaId?
    // Interface says unionId. Let's assume we filter batches by thana_id.
    // For now, let's just get any OPEN batch to simplify MVP.

    final response = await _supabase
        .from('batches')
        .select()
        .eq('status', 'OPEN')
        .limit(1)
        .maybeSingle();

    if (response == null) return null;

    // We also need current quantity (count orders in this batch)
    final countResponse = await _supabase
        .from('orders')
        .count()
        .eq('batch_id', response['id']);

    final batch = BatchModel.fromJson(response);

    // Return new object with updated count
    return BatchEntity(
      id: batch.id,
      thanaId: batch.thanaId,
      unionId: batch.unionId,
      startTime: batch.startTime,
      endTime: batch.endTime,
      targetQuantity: batch.targetQuantity,
      currentQuantity: countResponse, // Injected count
      status: batch.status,
    );
  }

  @override
  Future<List<BatchEntity>> getBatchHistory(String unionId) async {
    final response = await _supabase
        .from('batches')
        .select()
        .neq('status', 'OPEN')
        .order('end_at', ascending: false);

    final data = response as List<dynamic>;
    return data.map((json) => BatchModel.fromJson(json)).toList();
  }

  @override
  Stream<BatchEntity> watchBatchStatus(String batchId) {
    return _supabase
        .from('batches')
        .stream(primaryKey: ['id'])
        .eq('id', batchId)
        .map((event) => BatchModel.fromJson(event.first));
  }
}
