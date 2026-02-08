import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repositories_impl/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_active_products.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return ProductRepositoryImpl(client);
});

final getActiveProductsProvider = Provider<GetActiveProducts>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return GetActiveProducts(repo);
});

final activeProductsFutureProvider = FutureProvider((ref) {
  final usecase = ref.watch(getActiveProductsProvider);
  return usecase(limit: 20);
});
