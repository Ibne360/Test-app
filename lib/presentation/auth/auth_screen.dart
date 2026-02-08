import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('লগইন / রেজিস্টার')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('ফোন বা ইমেইল দিয়ে শুরু করুন'),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: 'ফোন নম্বর / ইমেইল',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/onboarding'),
              child: const Text('ওটিপি/পাসওয়ার্ড পাঠান'),
            ),
            const SizedBox(height: 12),
            const Text(
              'এমভিপি: শুধুমাত্র ডেমো ফ্লো।',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
