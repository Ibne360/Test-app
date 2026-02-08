import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchActiveProducts({int limit = 20});
}
