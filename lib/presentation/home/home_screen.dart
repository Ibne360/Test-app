import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ideally user's union ID should be fetched from user profile
    final userAsync = ref.watch(currentUserProvider);
    final productsAsync = ref.watch(activeProductsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ক্রেতা হোম'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.go('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () => context.go('/orders'),
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.go('/auth'),
                child: const Text('লগইন প্রয়োজন'),
              ),
            );
          }
          // Use user's unionId or a default for MVP demo if null
          final unionId = user.unionId ?? 'demo-union-id';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _BatchStatusCard(unionId: unionId),
              const SizedBox(height: 16),
              const Text(
                'পণ্যসমূহ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              productsAsync.when(
                data: (products) {
                  if (products.isEmpty) {
                    return const Text('কোনো পণ্য পাওয়া যায়নি।');
                  }
                  return Column(
                    children: products
                        .map(
                          (product) => Card(
                            child: ListTile(
                              leading: product.imageUrl != null
                                  ? Image.network(
                                      product.imageUrl!,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.image, size: 50),
                              title: Text(product.nameBn),
                              subtitle: Text(
                                '৳${product.price} • ${product.weightKg} কেজি',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () =>
                                  context.push('/product', extra: product),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Text('ত্রুটি: $error'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('User Error: $e')),
      ),
    );
  }
}

class _BatchStatusCard extends ConsumerWidget {
  final String unionId;
  const _BatchStatusCard({required this.unionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchAsync = ref.watch(currentBatchProvider(unionId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: batchAsync.when(
          data: (batch) {
            if (batch == null) {
              return const Text('বর্তমানে কোনো ব্যাচ চালু নেই।');
            }
            final progress = batch.currentQuantity / batch.targetQuantity;
            final remaining = batch.targetQuantity - batch.currentQuantity;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'চলমান ব্যাচ উইন্ডো',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'সমাপ্ত হতে বাকি: ${batch.timeRemaining.inHours} ঘন্টা',
                ), // Formatting simplified
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 8,
                ),
                const SizedBox(height: 8),
                Text(
                  remaining > 0
                      ? 'আর $remainingটি অর্ডার হলে ব্যাচ কনফার্ম হবে (${batch.currentQuantity}/${batch.targetQuantity})'
                      : 'ব্যাচ কনফার্ম হয়েছে! (${batch.currentQuantity}/${batch.targetQuantity})',
                ),
              ],
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text('ব্যাচ লোড হয়নি: $e'),
        ),
      ),
    );
  }
}
