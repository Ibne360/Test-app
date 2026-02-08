import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetActiveProducts {
  const GetActiveProducts(this._repository);

  final ProductRepository _repository;

  Future<List<Product>> call({int limit = 20}) {
    return _repository.fetchActiveProducts(limit: limit);
  }
}
