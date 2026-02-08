import 'package:flutter/material.dart';

import '../../core/utils/pricing_utils.dart';

class ManagerScreen extends StatelessWidget {
  const ManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courierCostExample = courierCost(100);
    final perOrder = courierCostExample / 50;

    return Scaffold(
      appBar: AppBar(title: const Text('থানা ম্যানেজার')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: const Text('বর্তমান ব্যাচ'),
              subtitle: Text('মোট অর্ডার: ৫০ • মোট ওজন: ১০০ কেজি'),
              trailing: Text('কুরিয়ার: ৳$courierCostExample'),
            ),
          ),
          const SizedBox(height: 8),
          Text('উদাহরণ: ১০০ কেজি হলে কুরিয়ার ৳$courierCostExample, প্রতি অর্ডার ~৳${perOrder.toStringAsFixed(0)}'),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: () {}, child: const Text('বাল্ক গ্রহণ নিশ্চিত করুন')),
          ElevatedButton(onPressed: () {}, child: const Text('প্যাকিং সম্পন্ন')),
          ElevatedButton(onPressed: () {}, child: const Text('স্ট্যাটাস আপডেট')),
        ],
      ),
    );
  }
}
