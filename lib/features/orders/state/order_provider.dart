import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';

enum OrderStatus { empty, paid, driverToMerchant, driverToUser, completed }

const String _activeOrderStorageKey = 'active_order';

class ActiveOrder {
  final String orderId;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final String paymentMethod;
  final String merchantName;
  final OrderStatus status;
  final bool hasRated;

  const ActiveOrder({
    required this.orderId,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.paymentMethod,
    required this.merchantName,
    this.status = OrderStatus.paid,
    this.hasRated = false,
  });

  double get total => subtotal + deliveryFee + serviceFee;

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  ActiveOrder copyWith({OrderStatus? status, bool? hasRated}) {
    return ActiveOrder(
      orderId: orderId,
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      serviceFee: serviceFee,
      paymentMethod: paymentMethod,
      merchantName: merchantName,
      status: status ?? this.status,
      hasRated: hasRated ?? this.hasRated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'items': items.map(_cartItemToJson).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'serviceFee': serviceFee,
      'paymentMethod': paymentMethod,
      'merchantName': merchantName,
      'status': status.name,
      'hasRated': hasRated,
    };
  }

  static ActiveOrder? fromJson(Map<String, dynamic> json) {
    final statusName = json['status'] as String?;
    final status = _orderStatusFromName(statusName);
    final rawItems = json['items'];

    if (status == null || rawItems is! List) return null;

    return ActiveOrder(
      orderId: json['orderId'] as String,
      items: List<CartItem>.unmodifiable(
        rawItems
            .whereType<Map<String, dynamic>>()
            .map(_cartItemFromJson)
            .toList(),
      ),
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      serviceFee: (json['serviceFee'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      merchantName: _normalizeBrandName(json['merchantName'] as String),
      status: status,
      hasRated: json['hasRated'] as bool? ?? false,
    );
  }
}

class OrderNotifier extends Notifier<ActiveOrder?> {
  @override
  ActiveOrder? build() {
    unawaited(_restoreOrder());
    return null;
  }

  void createFromCart({
    required CartState cart,
    required double deliveryFee,
    required double serviceFee,
    required String paymentMethod,
  }) {
    if (cart.items.isEmpty) return;

    final order = ActiveOrder(
      orderId: 'DNX-${DateTime.now().millisecondsSinceEpoch}',
      items: List<CartItem>.unmodifiable(cart.items),
      subtotal: cart.subtotal,
      deliveryFee: deliveryFee,
      serviceFee: serviceFee,
      paymentMethod: paymentMethod,
      merchantName: cart.items.first.merchantName,
    );

    state = order;
    unawaited(_saveOrder(order));
  }

  void updateStatus(OrderStatus status) {
    final current = state;
    if (current == null) return;
    if (status.index <= current.status.index) return;

    final order = current.copyWith(status: status);
    state = order;
    unawaited(_saveOrder(order));
  }

  void markRated() {
    final current = state;
    if (current == null) return;
    final order = current.copyWith(hasRated: true);
    state = order;
    unawaited(_saveOrder(order));
  }

  Future<void> _restoreOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final rawOrder = prefs.getString(_activeOrderStorageKey);
    if (rawOrder == null || state != null) return;

    try {
      final decoded = jsonDecode(rawOrder);
      if (decoded is! Map<String, dynamic>) return;

      state = ActiveOrder.fromJson(decoded);
    } on FormatException {
      await prefs.remove(_activeOrderStorageKey);
    } on TypeError {
      await prefs.remove(_activeOrderStorageKey);
    }
  }

  Future<void> _saveOrder(ActiveOrder order) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeOrderStorageKey, jsonEncode(order.toJson()));
  }
}

final orderProvider = NotifierProvider<OrderNotifier, ActiveOrder?>(() {
  return OrderNotifier();
});

Map<String, dynamic> _cartItemToJson(CartItem item) {
  return {
    'id': item.id,
    'name': item.name,
    'chineseName': item.chineseName,
    'price': item.price,
    'image': item.image,
    'description': item.description,
    'merchantName': item.merchantName,
    'merchantDistance': item.merchantDistance,
    'rating': item.rating,
    'soldCount': item.soldCount,
    'badge': item.badge,
    'quantity': item.quantity,
  };
}

CartItem _cartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    id: json['id'] as String?,
    name: json['name'] as String,
    chineseName: json['chineseName'] as String? ?? '',
    price: (json['price'] as num).toDouble(),
    image: json['image'] as String,
    description: json['description'] as String,
    merchantName: _normalizeBrandName(
      json['merchantName'] as String? ?? 'Dimsum Nuraos Express',
    ),
    merchantDistance: json['merchantDistance'] as String? ?? '0.8 km',
    rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
    soldCount: json['soldCount'] as String? ?? '500+ terjual',
    badge: json['badge'] as String? ?? '',
    quantity: json['quantity'] as int? ?? 1,
  );
}

OrderStatus? _orderStatusFromName(String? name) {
  for (final status in OrderStatus.values) {
    if (status.name == name) return status;
  }
  return null;
}

String _normalizeBrandName(String value) {
  return value.replaceAll('Dimsum Nuraos Xpress', 'Dimsum Nuraos Express');
}
