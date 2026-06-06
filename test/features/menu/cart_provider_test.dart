import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';

void main() {
  group('CartNotifier Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state should be empty', () {
      final cart = container.read(cartProvider);
      expect(cart.items, isEmpty);
      expect(cart.subtotal, 0.0);
      expect(cart.totalItems, 0);
    });

    test('Adding an item should increase count and subtotal', () {
      final item = CartItem(
        name: 'Ayam',
        price: 25000.0,
        image: 'img_url',
        description: 'savory',
      );

      container.read(cartProvider.notifier).addItem(item);

      final cart = container.read(cartProvider);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 1);
      expect(cart.totalItems, 1);
      expect(cart.subtotal, 25000.0);
    });

    test('Adding the same item twice should increase quantity', () {
      final item = CartItem(
        name: 'Ayam',
        price: 25000.0,
        image: 'img_url',
        description: 'savory',
      );

      container.read(cartProvider.notifier).addItem(item);
      container.read(cartProvider.notifier).addItem(item);

      final cart = container.read(cartProvider);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 2);
      expect(cart.totalItems, 2);
      expect(cart.subtotal, 50000.0);
    });

    test('Removing an item should decrease quantity or remove it', () {
      final item = CartItem(
        name: 'Ayam',
        price: 25000.0,
        image: 'img_url',
        description: 'savory',
      );

      container.read(cartProvider.notifier).addItem(item);
      container.read(cartProvider.notifier).addItem(item); // Qty is 2

      container.read(cartProvider.notifier).removeItem('Ayam');
      var cart = container.read(cartProvider);
      expect(cart.items.first.quantity, 1);
      expect(cart.totalItems, 1);

      container.read(cartProvider.notifier).removeItem('Ayam');
      cart = container.read(cartProvider);
      expect(cart.items, isEmpty);
      expect(cart.totalItems, 0);
    });

    test('Clearing cart should empty all items', () {
      final item = CartItem(
        name: 'Ayam',
        price: 25000.0,
        image: 'img_url',
        description: 'savory',
      );

      container.read(cartProvider.notifier).addItem(item);
      container.read(cartProvider.notifier).clear();

      final cart = container.read(cartProvider);
      expect(cart.items, isEmpty);
      expect(cart.totalItems, 0);
    });
  });
}
