import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('অর্ডারসমূহ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              title: Text('অর্ডার #১২৩৪৫'),
              subtitle: Text('স্ট্যাটাস: প্যাকড'),
              trailing: Text('৳৫৫০'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('অর্ডার #১২৩৪৬'),
              subtitle: Text('স্ট্যাটাস: ডেলিভার্ড'),
              trailing: Text('৳৭৫০'),
            ),
          ),
        ],
      ),
    );
  }
}
