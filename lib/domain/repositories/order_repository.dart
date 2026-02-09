import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getMyOrders(String userId);
  Future<OrderEntity?> getOrderById(String orderId);
  Future<void> createOrder(OrderEntity order);
  Future<void> cancelOrder(String orderId);
}
