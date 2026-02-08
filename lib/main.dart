import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'presentation/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');
  } catch (error) {
    debugPrint('dotenv লোড হয়নি: $error');
  }

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl == null || supabaseAnonKey == null) {
    debugPrint('Supabase env ভ্যারিয়েবল পাওয়া যায়নি');
  } else {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      debugPrint('Supabase ইনিশিয়ালাইজড');
    } catch (error) {
      debugPrint('Supabase ইনিশিয়ালাইজ ব্যর্থ: $error');
    }
  }

  runApp(const ProviderScope(child: ThanaGroupApp()));
}

class ThanaGroupApp extends StatelessWidget {
  const ThanaGroupApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = buildRouter();
    return MaterialApp.router(
      title: 'থানা গ্রুপ বাইং',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF0F766E),
        fontFamily: 'Roboto',
      ),
      routerConfig: router,
    );
  }
}
