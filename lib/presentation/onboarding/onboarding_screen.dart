import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? district;
  String? thana;
  String? union;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('লোকেশন বাছাই')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: district,
              decoration: const InputDecoration(
                labelText: 'জেলা',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'ঢাকা', child: Text('ঢাকা')),
              ],
              onChanged: (value) => setState(() => district = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: thana,
              decoration: const InputDecoration(
                labelText: 'থানা',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'ধানমন্ডি', child: Text('ধানমন্ডি')),
              ],
              onChanged: (value) => setState(() => thana = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: union,
              decoration: const InputDecoration(
                labelText: 'ইউনিয়ন',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'ইউনিয়ন-১', child: Text('ইউনিয়ন-১')),
              ],
              onChanged: (value) => setState(() => union = value),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('এগিয়ে যান'),
            ),
          ],
        ),
      ),
    );
  }
}
