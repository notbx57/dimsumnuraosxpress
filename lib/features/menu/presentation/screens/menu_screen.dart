import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/assets/app_assets.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';
import 'package:dimsumnuraosxpress/core/widgets/app_bottom_nav.dart';
import 'package:dimsumnuraosxpress/core/widgets/app_image.dart';
import 'package:dimsumnuraosxpress/core/widgets/skeleton_loader.dart';
import 'package:dimsumnuraosxpress/features/menu/data/mock_dish_data.dart';
import 'package:dimsumnuraosxpress/features/menu/presentation/widgets/menu_detail_sheet.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatRupiah(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.canPop() ? context.pop() : context.go('/'),
        ),
        title: Text(
          'Menu Dimsum',
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Keranjang',
            onPressed: () => context.push('/cart'),
            icon: Badge(
              isLabelVisible: cart.totalItems > 0,
              label: Text(cart.totalItems.toString()),
              child: const Icon(
                Icons.shopping_basket,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BackendLoadingSimulator(
        delay: const Duration(milliseconds: 950),
        skeleton: const _MenuSkeleton(),
        child: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverToBoxAdapter(child: _buildHeroBanner()),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _StickyTabsDelegate(
                      TabBar(
                        controller: _tabController,
                        indicatorColor: AppColors.primary,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.onSurfaceVariant,
                        labelStyle: AppTextStyles.labelMd,
                        tabs: const [
                          Tab(text: 'Best Seller'),
                          Tab(text: 'Paket'),
                          Tab(text: 'Mitra'),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildMenuList(mockBestSellerItems),
                  _buildMenuList(mockBundleItems),
                  _buildMerchantMenu(),
                ],
              ),
            ),
            if (cart.totalItems > 0)
              Positioned(
                left: 20,
                right: 20,
                bottom: 16,
                child: _CartFloatingBar(
                  totalItems: cart.totalItems,
                  subtotal: _formatRupiah(cart.subtotal),
                  onTap: () => context.push('/cart'),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(activeTab: AppTab.none),
    );
  }

  Widget _buildHeroBanner() {
    return SizedBox(
      height: 230,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const AppImage(source: AppAssets.dimsumDeliveryHero),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.72),
                  Colors.black.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dimsum pilihan mitra',
                  style: AppTextStyles.headlineMd.copyWith(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _HeroChip(icon: Icons.star, text: 'Rating 4.8+'),
                    _HeroChip(icon: Icons.local_fire_department, text: 'Top'),
                    _HeroChip(icon: Icons.delivery_dining, text: '15-25 mnt'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(List<CartItem> items) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final item = items[index];
        final currentQty = ref
            .watch(cartProvider)
            .items
            .where((cartItem) => cartItem.id == item.id)
            .fold(0, (sum, cartItem) => sum + cartItem.quantity);

        return _MenuItemCard(
          item: item,
          price: _formatRupiah(item.price),
          quantity: currentQty,
          onOpen: () => _showMenuDetail(item),
          onAdd: () => ref.read(cartProvider.notifier).addItem(item),
          onRemove: () => ref.read(cartProvider.notifier).removeItem(item.id),
        );
      },
    );
  }

  Widget _buildMerchantMenu() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
      itemCount: mockMerchantNames.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final name = mockMerchantNames[index];
        final item = mockAllMenuItems[index % mockAllMenuItems.length];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              AppImage(
                source: AppAssets.dimsumDeliveryHero,
                width: 74,
                height: 74,
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.labelMd.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${item.rating.toStringAsFixed(1)} rating - ${item.merchantDistance} dari Anda',
                      style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: const [
                        _SmallTag(text: 'Best seller'),
                        _SmallTag(text: 'Cepat'),
                        _SmallTag(text: 'Halal'),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.primary),
            ],
          ),
        );
      },
    );
  }

  List<CartItem> _relatedItemsFor(CartItem selectedItem) {
    return mockAllMenuItems.where((item) {
      return item.merchantName == selectedItem.merchantName &&
          item.id != selectedItem.id;
    }).toList();
  }

  void _showMenuDetail(CartItem item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return MenuDetailSheet(
          item: item,
          relatedItems: _relatedItemsFor(item),
          formatPrice: _formatRupiah,
          onAdd: _addItemFromDetail,
          onOpenRelated: (relatedItem) {
            Navigator.of(sheetContext).pop();
            Future<void>.microtask(() {
              if (!mounted) return;
              _showMenuDetail(relatedItem);
            });
          },
        );
      },
    );
  }

  void _addItemFromDetail(CartItem item) {
    ref.read(cartProvider.notifier).addItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} masuk keranjang'),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }
}

class _MenuSkeleton extends StatelessWidget {
  const _MenuSkeleton();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SkeletonBox(height: 230, borderRadius: 0),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyTabsDelegate(
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Row(
                children: [
                  Expanded(child: SkeletonBox(height: 32, borderRadius: 18)),
                  SizedBox(width: 10),
                  Expanded(child: SkeletonBox(height: 32, borderRadius: 18)),
                  SizedBox(width: 10),
                  Expanded(child: SkeletonBox(height: 32, borderRadius: 18)),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(childCount: 5, (
              context,
              index,
            ) {
              return Padding(
                padding: EdgeInsets.only(bottom: index == 4 ? 0 : 14),
                child: const _MenuItemCardSkeleton(),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _MenuItemCardSkeleton extends StatelessWidget {
  const _MenuItemCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.25),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(width: 104, height: 104, borderRadius: 12),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: SkeletonBox(height: 18, borderRadius: 6)),
                    SizedBox(width: 16),
                    SkeletonBox(width: 76, height: 16, borderRadius: 6),
                  ],
                ),
                SizedBox(height: 10),
                SkeletonBox(width: 120, height: 12, borderRadius: 6),
                SizedBox(height: 8),
                SkeletonBox(
                  width: double.infinity,
                  height: 12,
                  borderRadius: 6,
                ),
                SizedBox(height: 6),
                SkeletonBox(width: 160, height: 12, borderRadius: 6),
                SizedBox(height: 13),
                Row(
                  children: [
                    SkeletonBox(width: 90, height: 12, borderRadius: 6),
                    Spacer(),
                    SkeletonBox(width: 28, height: 28, borderRadius: 8),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItemCard extends StatelessWidget {
  const _MenuItemCard({
    required this.item,
    required this.price,
    required this.quantity,
    required this.onOpen,
    required this.onAdd,
    required this.onRemove,
  });

  final CartItem item;
  final String price;
  final int quantity;
  final VoidCallback onOpen;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onOpen,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AppImage(
                    source: item.image,
                    width: 104,
                    height: 104,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  if (item.badge.isNotEmpty)
                    Positioned(
                      left: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.badge,
                          style: AppTextStyles.labelSm.copyWith(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.labelMd.copyWith(fontSize: 16),
                          ),
                        ),
                        Text(
                          price,
                          style: AppTextStyles.labelMd.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.merchantName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 15),
                        const SizedBox(width: 3),
                        Text(
                          item.rating.toStringAsFixed(1),
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.onBackground,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.soldCount,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.labelSm.copyWith(fontSize: 10),
                          ),
                        ),
                        if (quantity > 0) ...[
                          _QtyButton(icon: Icons.remove, onTap: onRemove),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(quantity.toString()),
                          ),
                        ],
                        _QtyButton(
                          icon: Icons.add,
                          isPrimary: true,
                          onTap: onAdd,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartFloatingBar extends StatelessWidget {
  const _CartFloatingBar({
    required this.totalItems,
    required this.subtotal,
    required this.onTap,
  });

  final int totalItems;
  final String subtotal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Badge(
                label: Text(totalItems.toString()),
                child: const Icon(Icons.shopping_basket, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$totalItems item di keranjang',
                      style: AppTextStyles.labelSm.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtotal,
                      style: AppTextStyles.labelMd.copyWith(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Lihat',
                style: AppTextStyles.labelMd.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isPrimary ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.32)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 5),
          Text(
            text,
            style: AppTextStyles.labelSm.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallTag extends StatelessWidget {
  const _SmallTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSm.copyWith(
          color: AppColors.onSurfaceVariant,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _StickyTabsDelegate extends SliverPersistentHeaderDelegate {
  _StickyTabsDelegate(this.tabBar);

  final Widget tabBar;

  @override
  double get minExtent => 52;

  @override
  double get maxExtent => 52;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.surface, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _StickyTabsDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}
