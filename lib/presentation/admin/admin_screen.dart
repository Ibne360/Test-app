import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('অ্যাডমিন কনফিগ')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('মিনিমাম অর্ডার সংখ্যা'),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '১০',
            ),
          ),
          const SizedBox(height: 12),
          const Text('সাইকেল ডিউরেশন (দিন/ঘন্টা)'),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '৭ দিন',
            ),
          ),
          const SizedBox(height: 12),
          const Text('কুরিয়ার প্রাইসিং'),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'প্রথম ১ কেজি: ৳১২০',
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            child: const Text('ব্যাচ ক্লোজ চালান'),
          ),
        ],
      ),
    );
  }
}
