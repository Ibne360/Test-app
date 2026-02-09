import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart'; // For currentUserProvider, orderRepositoryProvider
import '../../core/enums.dart'; // For OrderStatus
import '../../domain/entities/order_entity.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('আমার অর্ডার')),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('অর্ডার দেখতে লগইন করুন'));
          }

          // Use a FutureProvider.family scoped/autoDispose would be best,
          // but for checking here, let's just use ref.watch on a provider we define inline or reuse.
          // Or just call repository directly but wrap in FutureBuilder - keeping in mind the rebuild issue.
          // To solve rebuild issue cleanly without new provider file:

          return _OrderList(userId: user.id);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _OrderList extends ConsumerStatefulWidget {
  final String userId;
  const _OrderList({required this.userId});

  @override
  ConsumerState<_OrderList> createState() => _OrderListState();
}

class _OrderListState extends ConsumerState<_OrderList> {
  late Future<List<OrderEntity>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture =
        ref.read(orderRepositoryProvider).getMyOrders(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderEntity>>(
      future: _ordersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('ত্রুটি: ${snapshot.error}'));
        }

        final orders = snapshot.data ?? [];
        if (orders.isEmpty) {
          return const Center(child: Text('কোনো অর্ডার নেই'));
        }

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ExpansionTile(
                title: Text('অর্ডার #${order.id.substring(0, 8)}...'),
                subtitle: Text(
                  '৳${order.totalAmount.toStringAsFixed(0)} • ${_statusText(order.status)}',
                ),
                children: order.items
                    .map(
                      (item) => ListTile(
                        title: Text(item.productName),
                        trailing: Text(
                          '${item.quantity} x ৳${item.priceAtPurchase}',
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }

  String _statusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'পেন্ডিং'; // Corrected spelling/term
      case OrderStatus.confirmed:
        return 'কনফার্মড';
      case OrderStatus.processing:
        return 'প্রসেসিং';
      case OrderStatus.shipped:
        return 'শিপড';
      case OrderStatus.delivered:
        return 'ডেলিভার্ড';
      case OrderStatus.cancelled:
        return 'বাতিল';
      // default:
      //   return status.name;
    }
  }
}
