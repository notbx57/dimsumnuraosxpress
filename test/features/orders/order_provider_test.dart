import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';
import 'package:dimsumnuraosxpress/features/orders/state/order_provider.dart';

void main() {
  group('OrderNotifier persistence', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('persists active order status and restores it', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final item = CartItem(
        name: 'Siomay Ayam',
        price: 25000,
        image: 'assets/images/dimsum_delivery_hero.png',
        description: 'Ayam cincang gurih',
      );
      final cart = CartState(items: [item.copyWith(quantity: 2)]);

      container
          .read(orderProvider.notifier)
          .createFromCart(
            cart: cart,
            deliveryFee: 12000,
            serviceFee: 2500,
            paymentMethod: 'Dompet Digital',
          );
      container
          .read(orderProvider.notifier)
          .updateStatus(OrderStatus.driverToUser);
      await _waitForStorageWrite();
      container.dispose();

      final restoredContainer = ProviderContainer();
      addTearDown(restoredContainer.dispose);
      restoredContainer.read(orderProvider);
      await _waitForRestore();

      final restoredOrder = restoredContainer.read(orderProvider);
      expect(restoredOrder, isNotNull);
      expect(restoredOrder!.status, OrderStatus.driverToUser);
      expect(restoredOrder.items.single.quantity, 2);
      expect(restoredOrder.total, 64500);
    });

    test('does not persist a status downgrade', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final cart = CartState(
        items: [
          CartItem(
            name: 'Hakau',
            price: 32000,
            image: 'assets/images/dimsum_delivery_hero.png',
            description: 'Udang premium',
          ),
        ],
      );

      final notifier = container.read(orderProvider.notifier);
      notifier.createFromCart(
        cart: cart,
        deliveryFee: 12000,
        serviceFee: 2500,
        paymentMethod: 'Dompet Digital',
      );
      notifier.updateStatus(OrderStatus.completed);
      notifier.updateStatus(OrderStatus.driverToMerchant);
      await _waitForStorageWrite();

      expect(container.read(orderProvider)!.status, OrderStatus.completed);
    });
  });
}

Future<void> _waitForRestore() {
  return Future<void>.delayed(const Duration(milliseconds: 20));
}

Future<void> _waitForStorageWrite() {
  return Future<void>.delayed(const Duration(milliseconds: 20));
}
