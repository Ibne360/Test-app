import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('কার্ট')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ListTile(
              title: Text('চাল ৫ কেজি'),
              subtitle: Text('পরিমাণ: ১'),
              trailing: Text('৳৫০০'),
            ),
            const Divider(),
            const ListTile(
              title: Text('ডেলিভারি চার্জ'),
              trailing: Text('৳৫০'),
            ),
            const ListTile(
              title: Text('সার্ভিস চার্জ'),
              trailing: Text('৳০'),
            ),
            const ListTile(
              title: Text('মোট'),
              trailing: Text('৳৫৫০'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('অর্ডার কনফার্ম'),
            ),
          ],
        ),
      ),
    );
  }
}
