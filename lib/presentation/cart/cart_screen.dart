import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/enums.dart';
import '../../core/providers.dart';
import '../../domain/entities/order_entity.dart';
import 'cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool _isOrdering = false;

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final userAsync = ref.watch(currentUserProvider);

    final total = ref.read(cartProvider.notifier).totalAmount;

    return Scaffold(
      appBar: AppBar(title: const Text('আপনার কার্ট')),
      body: cartItems.isEmpty
          ? const Center(child: Text('কার্ট খালি'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: item.product.imageUrl != null
                            ? Image.network(
                                item.product.imageUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image),
                        title: Text(item.product.nameBn),
                        subtitle: Text(
                          '৳${item.product.price} x ${item.quantity} = ৳${item.totalPrice}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => ref
                                  .read(cartProvider.notifier)
                                  .decrement(item.product),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => ref
                                  .read(cartProvider.notifier)
                                  .increment(item.product),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'মোট: ৳${total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isOrdering
                              ? null
                              : () async {
                                  final user = userAsync.value;
                                  if (user == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('অর্ডার করতে লগইন করুন'),
                                      ),
                                    );
                                    context.push('/auth');
                                    return;
                                  }

                                  setState(() => _isOrdering = true);

                                  try {
                                    final batchEntity = await ref
                                        .read(batchRepositoryProvider)
                                        .getCurrentBatch(user.unionId ?? '');

                                    // If no batch, maybe warn but allow for demo/test if configured?
                                    // For now sticking to warning but proceeding if batchId optional or handle gracefully.
                                    // DB requires batch_id if strict, let's assume one exists or we just pass null/placeholder if allowed.
                                    // Actually schema `orders.batch_id references batches`. It is nullable in my entity but strict in schema?
                                    // Schema: `batch_id uuid references batches(id)`. It is nullable by default in Postgres if not `not null`.
                                    // Checked schema: `batch_id uuid references batches(id)`. No `not null`. So it's fine.

                                    final order = OrderEntity(
                                      id: '', // Placeholder, ignored by repository insert
                                      userId: user.id,
                                      items: cartItems
                                          .map(
                                            (c) => OrderItem(
                                              productId: c.product.id,
                                              productName: c.product.nameBn,
                                              quantity: c.quantity,
                                              priceAtPurchase: c.product.price,
                                            ),
                                          )
                                          .toList(),
                                      totalAmount: total.toDouble(),
                                      status: OrderStatus.pending, // PLACED
                                      createdAt: DateTime.now(),
                                      batchId: batchEntity?.id,
                                    );

                                    await ref
                                        .read(orderRepositoryProvider)
                                        .createOrder(order);

                                    ref.read(cartProvider.notifier).clearCart();
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('অর্ডার সফল হয়েছে!'),
                                        ),
                                      );
                                      context.go('/');
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text('ত্রুটি: $e')),
                                      );
                                    }
                                  } finally {
                                    if (mounted)
                                      setState(() => _isOrdering = false);
                                  }
                                },
                          child: _isOrdering
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('অর্ডার নিশ্চিত করুন'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
