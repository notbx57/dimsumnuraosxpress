import 'package:flutter/material.dart';
import 'package:dimsumnuraosxpress/features/cart/presentation/screens/cart_screen.dart';
import 'package:dimsumnuraosxpress/features/home/presentation/screens/home_screen.dart';
import 'package:dimsumnuraosxpress/features/menu/presentation/screens/menu_screen.dart';
import 'package:dimsumnuraosxpress/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:dimsumnuraosxpress/features/tracking/presentation/screens/tracking_screen.dart';
import 'package:dimsumnuraosxpress/features/review/presentation/screens/review_screen.dart';
import 'package:dimsumnuraosxpress/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: const HomeScreen()),
    ),
    GoRoute(
      path: '/menu',
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: const MenuScreen()),
    ),
    GoRoute(
      path: '/cart',
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: const CartScreen()),
    ),
    GoRoute(
      path: '/checkout',
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: const CheckoutScreen()),
    ),
    GoRoute(
      path: '/tracking',
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: const TrackingScreen()),
    ),
    GoRoute(
      path: '/review',
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: const ReviewScreen()),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) =>
          _buildPage(state: state, child: const ProfileScreen()),
    ),
  ],
);

CustomTransitionPage<void> _buildPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 220),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      );

      return FadeTransition(
        opacity: curve,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.992, end: 1).animate(curve),
          child: child,
        ),
      );
    },
  );
}
