import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _BatchStatusCard(),
          const SizedBox(height: 16),
          const Text('পণ্যসমূহ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          title: Text(product.nameBn),
                          subtitle: Text('৳${product.price} • ${product.weightKg} কেজি'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.go('/product'),
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
      ),
    );
  }
}

class _BatchStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('চলমান ব্যাচ উইন্ডো', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('সমাপ্ত হতে বাকি: ২ দিন ১২ ঘন্টা'),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: 0.7, minHeight: 8),
            const SizedBox(height: 8),
            const Text('আর ৩টি অর্ডার হলে ব্যাচ কনফার্ম হবে (৭/১০)'),
          ],
        ),
      ),
    );
  }
}
