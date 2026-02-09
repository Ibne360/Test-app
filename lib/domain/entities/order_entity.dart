import '../../core/enums.dart';

class OrderEntity {
  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.batchId,
    this.deliveryAddress,
  });

  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime createdAt;
  final String? batchId;
  final String? deliveryAddress;
}

class OrderItem {
  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.priceAtPurchase,
  });

  final String productId;
  final String productName;
  final int quantity;
  final int priceAtPurchase;
}
