import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('পণ্যের বিস্তারিত')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('পণ্যের নাম', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('ওজন: ১ কেজি'),
            const Text('দাম: ৳২৫০'),
            const Text('প্রত্যাশিত ডেলিভারি: শুক্রবার'),
            const SizedBox(height: 12),
            const Text('ব্যাচ নিয়মাবলি: ব্যাচ কনফার্ম হলে প্রোডাক্ট আনানো হবে।'),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go('/cart'),
              child: const Text('কার্টে যোগ করুন'),
            ),
          ],
        ),
      ),
    );
  }
}
