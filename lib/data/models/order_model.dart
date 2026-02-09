import '../../domain/entities/order_entity.dart';
import '../../core/enums.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.totalAmount,
    required super.status,
    required super.createdAt,
    super.batchId,
    super.deliveryAddress, // Not in schema explicitly, maybe derived?
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var list = json['order_items'] as List? ?? [];
    List<OrderItem> itemsList = list
        .map((i) => OrderItemModel.fromJson(i))
        .toList();

    return OrderModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      items: itemsList,
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: _parseStatus(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      batchId: json['batch_id'] as String?,
      deliveryAddress: null, // Placeholder
    );
  }

  static OrderStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return OrderStatus.confirmed;
      case 'SHIPPED':
        return OrderStatus.shipped;
      case 'DELIVERED':
        return OrderStatus.delivered;
      case 'CANCELLED':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'batch_id': batchId,
      'status': status.name.toUpperCase(), // basic mapping
      'total_amount': totalAmount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.productId,
    required super.productName, // Needs join to get name
    required super.quantity,
    required super.priceAtPurchase,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    // Assuming join with products table: products(name_bn)
    final productData = json['products'] as Map<String, dynamic>?;

    return OrderItemModel(
      productId: json['product_id'] as String,
      productName: productData?['name_bn'] as String? ?? 'Product',
      quantity: (json['qty'] as num).toInt(),
      priceAtPurchase: (json['unit_price'] as num).toInt(),
    );
  }
}
