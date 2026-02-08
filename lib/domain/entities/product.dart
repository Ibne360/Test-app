class Product {
  const Product({
    required this.id,
    required this.nameBn,
    required this.descriptionBn,
    required this.price,
    required this.wholesalePrice,
    required this.weightKg,
    required this.imageUrl,
    required this.isActive,
    required this.stockMode,
    required this.maxPerBatch,
  });

  final String id;
  final String nameBn;
  final String descriptionBn;
  final int price;
  final int? wholesalePrice;
  final double weightKg;
  final String? imageUrl;
  final bool isActive;
  final String stockMode;
  final int? maxPerBatch;
}
