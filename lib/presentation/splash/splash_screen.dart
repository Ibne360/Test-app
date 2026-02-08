import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 1), () {
      if (context.mounted) {
        context.go('/auth');
      }
    });

    return const Scaffold(
      body: Center(
        child: Text(
          'থানা গ্রুপ বাইং',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
