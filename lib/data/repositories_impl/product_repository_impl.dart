import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Product>> fetchActiveProducts({int limit = 20}) async {
    final response = await _client
        .from('products')
        .select()
        .eq('is_active', true)
        .limit(limit);

    final data = (response as List<dynamic>)
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
    return data;
  }
}
