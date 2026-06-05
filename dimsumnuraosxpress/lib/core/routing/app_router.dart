import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/features/home/presentation/screens/home_screen.dart';
import 'package:dimsumnuraosxpress/features/menu/presentation/screens/menu_screen.dart';
import 'package:dimsumnuraosxpress/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:dimsumnuraosxpress/features/tracking/presentation/screens/tracking_screen.dart';
import 'package:dimsumnuraosxpress/features/review/presentation/screens/review_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) => const MenuScreen(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/tracking',
      builder: (context, state) => const TrackingScreen(),
    ),
    GoRoute(
      path: '/review',
      builder: (context, state) => const ReviewScreen(),
    ),
  ],
);
