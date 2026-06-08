import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';

enum AppTab { home, orders, cart, profile, none }

class AppBottomNav extends ConsumerWidget {
  const AppBottomNav({required this.activeTab, super.key});

  final AppTab activeTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Beranda',
              isActive: activeTab == AppTab.home,
              onTap: () => _goToTab(context, AppTab.home, '/'),
            ),
            _NavItem(
              icon: Icons.receipt_long,
              label: 'Pesanan',
              isActive: activeTab == AppTab.orders,
              onTap: () => _goToTab(context, AppTab.orders, '/tracking'),
            ),
            _NavItem(
              icon: Icons.shopping_basket,
              label: 'Keranjang',
              badgeCount: cart.totalItems,
              isActive: activeTab == AppTab.cart,
              onTap: () => _goToTab(context, AppTab.cart, '/cart'),
            ),
            _NavItem(
              icon: Icons.person,
              label: 'Profil',
              isActive: activeTab == AppTab.profile,
              onTap: () => _goToTab(context, AppTab.profile, '/profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _goToTab(BuildContext context, AppTab targetTab, String path) {
    if (activeTab == targetTab) return;

    final delta = _tabIndex(targetTab) - _tabIndex(activeTab);
    context.go(path, extra: delta == 0 ? 0 : delta.sign);
  }

  int _tabIndex(AppTab tab) {
    return switch (tab) {
      AppTab.home => 0,
      AppTab.orders => 1,
      AppTab.cart => 2,
      AppTab.profile => 3,
      AppTab.none => 0,
    };
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final int badgeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          icon,
          color: isActive
              ? AppColors.onSecondaryContainer
              : AppColors.onSurfaceVariant,
          size: 21,
        ),
        if (badgeCount > 0)
          Positioned(
            right: -10,
            top: -9,
            child: Container(
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: Text(
                badgeCount > 99 ? '99+' : badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );

    if (isActive) {
      return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              const SizedBox(width: 7),
              Text(
                label,
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SizedBox(
        width: 74,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
