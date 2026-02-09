import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repositories_impl/auth_repository_impl.dart';
import '../data/repositories_impl/batch_repository_impl.dart';
import '../data/repositories_impl/order_repository_impl.dart';
import '../data/repositories_impl/product_repository_impl.dart';
import '../domain/entities/user_entity.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/batch_repository.dart';
import '../domain/repositories/order_repository.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_active_products.dart';
import '../domain/entities/batch_entity.dart';

// Supabase Client
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Repositories
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return ProductRepositoryImpl(client);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return AuthRepositoryImpl(client);
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return OrderRepositoryImpl(client);
});

final batchRepositoryProvider = Provider<BatchRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return BatchRepositoryImpl(client);
});

// UseCases
final getActiveProductsProvider = Provider<GetActiveProducts>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return GetActiveProducts(repo);
});

// Providers
final activeProductsFutureProvider = FutureProvider((ref) {
  final usecase = ref.watch(getActiveProductsProvider);
  return usecase(limit: 20);
});

final authStateChangesProvider = StreamProvider<UserEntity?>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges;
});

final currentUserProvider = FutureProvider<UserEntity?>((ref) async {
  final repo = ref.watch(authRepositoryProvider);
  return repo.getCurrentUser();
});

// Batch Providers
final currentBatchProvider = FutureProvider.family<BatchEntity?, String>((
  ref,
  unionId,
) {
  final repo = ref.watch(batchRepositoryProvider);
  return repo.getCurrentBatch(unionId);
});
