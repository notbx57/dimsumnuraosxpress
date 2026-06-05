import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final String name;
  final String chineseName;
  final double price;
  final String image;
  final String description;
  final int quantity;

  CartItem({
    required this.name,
    this.chineseName = '',
    required this.price,
    required this.image,
    required this.description,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      name: name,
      chineseName: chineseName,
      price: price,
      image: image,
      description: description,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartState {
  final List<CartItem> items;

  CartState({this.items = const []});

  double get subtotal {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }
}

class CartNotifier extends Notifier<CartState> {
  @override
  CartState build() {
    return CartState();
  }

  void addItem(CartItem item) {
    final existingIndex = state.items.indexWhere((i) => i.name == item.name);
    if (existingIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(items: [...state.items, item]);
    }
  }

  void removeItem(String name) {
    final existingIndex = state.items.indexWhere((i) => i.name == name);
    if (existingIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      final existingItem = updatedItems[existingIndex];
      if (existingItem.quantity > 1) {
        updatedItems[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        );
      } else {
        updatedItems.removeAt(existingIndex);
      }
      state = state.copyWith(items: updatedItems);
    }
  }

  void clear() {
    state = CartState();
  }
}

final cartProvider = NotifierProvider<CartNotifier, CartState>(() {
  return CartNotifier();
});
