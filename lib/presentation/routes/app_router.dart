import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../admin/admin_screen.dart';
import '../auth/auth_screen.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../manager/manager_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../orders/orders_screen.dart';
import '../product/product_details_screen.dart';
import '../splash/splash_screen.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/product',
        builder: (context, state) => const ProductDetailsScreen(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/manager',
        builder: (context, state) => const ManagerScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('রাউট পাওয়া যায়নি: ${state.uri}'),
      ),
    ),
  );
}
