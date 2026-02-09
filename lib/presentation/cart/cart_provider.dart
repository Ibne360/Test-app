import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  int get totalPrice => product.price * quantity;
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    state = [...state, CartItem(product: product, quantity: 1)];
  }

  void increment(Product product) {
    state = [
      for (final item in state)
        if (item.product.id == product.id)
          CartItem(product: item.product, quantity: item.quantity + 1)
        else
          item,
    ];
  }

  void decrement(Product product) {
    state = [
      for (final item in state)
        if (item.product.id == product.id)
          if (item.quantity > 1)
            CartItem(product: item.product, quantity: item.quantity - 1)
          else
            item // or remove?
        else
          item,
    ].where((item) => item.quantity > 0).toList();
  }

  void removeFromCart(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void clearCart() {
    state = [];
  }

  double get totalAmount => state.fold(0, (sum, item) => sum + item.totalPrice);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
