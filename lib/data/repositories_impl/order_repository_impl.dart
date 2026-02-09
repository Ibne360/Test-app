import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final SupabaseClient _supabase;

  OrderRepositoryImpl(this._supabase);

  @override
  Future<List<OrderEntity>> getMyOrders(String userId) async {
    final response = await _supabase
        .from('orders')
        .select('*, order_items(*, products(name_bn))')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    final data = response as List<dynamic>;
    return data.map((json) => OrderModel.fromJson(json)).toList();
  }

  @override
  Future<OrderEntity?> getOrderById(String orderId) async {
    final response = await _supabase
        .from('orders')
        .select('*, order_items(*, products(name_bn))')
        .eq('id', orderId)
        .maybeSingle();

    if (response == null) return null;
    return OrderModel.fromJson(response);
  }

  @override
  Future<void> createOrder(OrderEntity order) async {
    // 1. Insert Order
    final orderResponse = await _supabase
        .from('orders')
        .insert({
          'user_id': order.userId,
          'batch_id': order
              .batchId, // Ensure batchId is valid or handle null if allowed
          'total_amount': order.totalAmount,
          'status': 'PLACED',
          'delivery_charge': 50, // Default for now
          'service_charge': 0,
          'total_weight_kg': 0, // Should calculate
        })
        .select()
        .single();

    final newOrderId = orderResponse['id'];

    // 2. Insert Items
    final itemsData = order.items
        .map(
          (item) => {
            'order_id': newOrderId,
            'product_id': item.productId,
            'qty': item.quantity,
            'unit_price': item.priceAtPurchase,
            'unit_weight_kg': 0, // Should fetch from product
          },
        )
        .toList();

    await _supabase.from('order_items').insert(itemsData);
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _supabase
        .from('orders')
        .update({'status': 'CANCELLED'})
        .eq('id', orderId);
  }
}
