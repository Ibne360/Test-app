import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product.dart';
import '../cart/cart_provider.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(product.nameBn)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrl != null)
              Image.network(
                product.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            Text(
              product.nameBn,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              '৳${product.price}',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              '${product.weightKg} কেজি',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(product.descriptionBn),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(cartProvider.notifier).addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('কার্টে যুক্ত হয়েছে')),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('কার্টে যোগ করুন'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
