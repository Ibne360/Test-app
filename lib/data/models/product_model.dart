import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.nameBn,
    required super.descriptionBn,
    required super.price,
    required super.wholesalePrice,
    required super.weightKg,
    required super.imageUrl,
    required super.isActive,
    required super.stockMode,
    required super.maxPerBatch,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      nameBn: json['name_bn'] as String? ?? '',
      descriptionBn: json['description_bn'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      wholesalePrice: (json['wholesale_price'] as num?)?.toInt(),
      weightKg: (json['weight_kg'] as num?)?.toDouble() ?? 0,
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      stockMode: json['stock_mode'] as String? ?? 'On-demand',
      maxPerBatch: (json['max_per_batch'] as num?)?.toInt(),
    );
  }
}
