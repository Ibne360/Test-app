import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('অ্যাডমিন প্যানেল')),
      body: const Center(child: Text('অ্যাডমিন সেটিংস')),
    );
  }
}
