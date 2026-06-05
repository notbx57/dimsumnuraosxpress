import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  
  final List<CartItem> signatureItems = [
    CartItem(
      name: 'Ayam',
      chineseName: '鸡',
      price: 25000.0,
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC8zRB7fnGTSyEiCsaA3XXGHgstmE3StecrJJWiVpg1awbnuj_-etsJsuBbmRqQC1aawrBo4h3DERWxdYeXPh2TiVZ7RodVheFWy7Xw9NLqnnR85WzWMU18V6FSOmGp-HqtOLqvyHl94lFf_YlsiJlRQ46547t6XCxMaLJruAzViqOdgIcZA-ly5SGvQIt2z4crYcszJvYb-fGQsT25jMQIzrczYVuwJ9cs66BG5ji3DF9VovYvpbd5DAltrz-Y50WK8-2OKJD6cU0',
      description: 'Pangsit kukus ayam klasik dengan kaldu gurih.',
    ),
    CartItem(
      name: 'Beef',
      chineseName: '牛',
      price: 28000.0,
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCKZw8Eufa3_e1QhhaEek5J-_8lp4bvW38Q_NV03V9-Fxgsrh00hWRXjad_s8-UqVflErt9qBigdOty6zTEQmtZXJZXheXj8czv6R4QTc0wNjNODB72yUDeQmHB8HC0yQgJxq2j6sMwEETrRmfVuR1x_rZZSH6bePzrt3hf1wPbrXAUQz0m7WJ6XQel02kFxqeH_oJ-C5zMBiZltpUPQHf_nt2aDU_ujhT6xo4yDDVWKRv-EMwmRgzxyfltq7wRZAC9jQ40HuG1TAI',
      description: 'Campuran daging sapi wagyu premium dengan rempah aromatik.',
    ),
    CartItem(
      name: 'Udang',
      chineseName: '虾',
      price: 32000.0,
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCi4pQhFrCXDBWosMQxYLUsg3K5Do5A_DB_HLQiyeBU6bQRkfFoBXb5qst8VKWkXD3HjA9Zxff2mkE3lo36iHs2iaIw-yVY9Psru5Gq7YsnJHnUrNg9Y-NDKT2JgnOHJl86O8yGHXErou-DV89WBKva10LF-oeDPYMNKBu3dVb1eAIo83uhSczY4C80xdHs0zNW2QxDezbLLZaFssYBv8sGme8sioWGUg8pbz72jQsv3U71SWJ0o2Q1e35SNb2w1QiZY-xrSIBZGtA',
      description: 'Udang segar utuh yang padat dibungkus dalam kulit kristal.',
    ),
    CartItem(
      name: 'Keju',
      chineseName: '芝士',
      price: 30000.0,
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCIG5ZsaZWVqSnlSJ5zngYOFAJx1hTOPxiZa6o3qS9e6XyBdoJ6VipYgy6arQmxxdBXK00qkmGVt4UC0_5a6ct6HgCKIpU8fBoEygNJzrVqC0Ebm39aYB8tIcnbtvtpqlYbB_xp6mc8m9weAUab6O_YXAUGBerUE-mDJxa56TUsI3u3evWmnxkZgdYy1g684QWupQ1RDrKGrESpvioiBmmzf6EwX2_1hsH9tKX9VYl89hbeHoHBpgBAQZSscVB9BqFnFqEsWBbGBM8',
      description: 'Perpaduan mozzarella lumer dengan basis ayam tradisional.',
    ),
  ];

  final List<CartItem> frozenItems = [
    CartItem(
      name: 'Paket Bundel Keluarga',
      price: 145000.0,
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDRiZcQvE42wn0W6GvNyYzce3EkVh6BJ9SrmGBDotAQQOIAJ6JZ3syfnhEQSrXepe0S1e3snXyXP0iv3j7NHDp9TEu8FLB2RigtgknmaUzZy1aVskWnaBR4f-jRJWp8FuhNfLP7tKws3um9bmKPebYF7JLBcnB1fjT03348hoZolCWgN7pF7xM3Kg1GNSSC9p0BcOvF_amV1T05D2BFu7MZBldnO7LZEcmIIpmpFhP7Pw8HD7gF5CxvblTGUwHo8WWUwmYB9mWPmRw',
      description: '24 Potong Campuran (Ayam, Sapi, Udang, Keju) dalam kemasan beku vakum.',
    ),
    CartItem(
      name: 'Ayam Beku',
      price: 75000.0,
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDRiZcQvE42wn0W6GvNyYzce3EkVh6BJ9SrmGBDotAQQOIAJ6JZ3syfnhEQSrXepe0S1e3snXyXP0iv3j7NHDp9TEu8FLB2RigtgknmaUzZy1aVskWnaBR4f-jRJWp8FuhNfLP7tKws3um9bmKPebYF7JLBcnB1fjT03348hoZolCWgN7pF7xM3Kg1GNSSC9p0BcOvF_amV1T05D2BFu7MZBldnO7LZEcmIIpmpFhP7Pw8HD7gF5CxvblTGUwHo8WWUwmYB9mWPmRw',
      description: '12 Potong Dimsum Ayam beku siap kukus.',
    ),
    CartItem(
      name: 'Udang Beku',
      price: 90000.0,
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCi4pQhFrCXDBWosMQxYLUsg3K5Do5A_DB_HLQiyeBU6bQRkfFoBXb5qst8VKWkXD3HjA9Zxff2mkE3lo36iHs2iaIw-yVY9Psru5Gq7YsnJHnUrNg9Y-NDKT2JgnOHJl86O8yGHXErou-DV89WBKva10LF-oeDPYMNKBu3dVb1eAIo83uhSczY4C80xdHs0zNW2QxDezbLLZaFssYBv8sGme8sioWGUg8pbz72jQsv3U71SWJ0o2Q1e35SNb2w1QiZY-xrSIBZGtA',
      description: '12 Potong Dimsum Udang beku siap kukus.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
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
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Menu Mitra',
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.outlineVariant, width: 1),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCiefWDcedbHEG__i9er7iAOjtCVUtXSpbfUiuHZfDVmn06YqZcKndkSqGNdCbb0PmTkaAtK2Ap8xkREZoQBQEdhv9jpCefPhnuQay_3pV45n0vYq9KBc6sZCgwLdSIsHqPjbDRoCzc0Af7PXNYw5hXxw0JuCtokEPZtLiG_g6gmT6BMdyaWu6t37Xi6oQJVnwgzP7f3yODxdUNhAjhfiyXJX-d4JcXN2o1Y6QA10bniAxl4CaEFbolDCq_ExYZZfY3Mwlfegoh2pQ',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
            height: 1.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero banner
                _buildHeroBanner(),

                // Sticky Tab Bar
                Container(
                  color: AppColors.surfaceBright,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.onSurfaceVariant,
                    labelStyle: AppTextStyles.labelMd,
                    tabs: const [
                      Tab(text: 'Rasa Khas'),
                      Tab(text: 'Paket Beku'),
                      Tab(text: 'Minuman'),
                    ],
                  ),
                ),

                // Tab Content View items
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1: Signature Items
                      _buildSectionTitle('Rasa Khas', 'Memiliki 4 Varian'),
                      const SizedBox(height: 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: signatureItems.length,
                        itemBuilder: (context, index) {
                          final item = signatureItems[index];
                          return _buildMenuItemCard(item);
                        },
                      ),
                      const SizedBox(height: 32),

                      // Section 2: Frozen Pack Items
                      _buildSectionTitle('Paket Beku', 'Siap Kukus di Rumah'),
                      const SizedBox(height: 16),
                      _buildFrozenBentoGrid(),
                      const SizedBox(height: 100), // padding bottom for cart overlay
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom persistent Cart overlay
          if (cart.totalItems > 0)
            Positioned(
              bottom: 96,
              left: 20,
              right: 20,
              child: _buildCartBottomBar(cart),
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuABT6gTv3uMZNt2531ri4xz03yUHZPJJ8oUtpshnxsYU8hmlG6ecS5ikZVvRmhB2a8U80IhIhjPCvYpWuwqCfF3JLWHlaoK7V4Gb0sCeLiuO0S5Y6NA8wO_mxqR-FLvcvz3iT1uKcedySmn44f_2YhybBR53ryDngQSVlU3SbYp-8w_eiEw2oT6JPB4UEcCYYi9OYMiiQQDpeD5_i6lMEgBveT5pOU5O1RjA_GluecekcKyykgD4dIRv0t44HngyYu4U7zmmrUdkxI',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: 0.7),
              Colors.black.withValues(alpha: 0.1),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Dimsum Nuraos',
              style: AppTextStyles.headlineXl.copyWith(color: Colors.white, fontSize: 32),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  '4.8 (2rb+ ulasan) • 15-25 menit',
                  style: AppTextStyles.labelSm.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineMd.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: AppTextStyles.bodySm.copyWith(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildMenuItemCard(CartItem item) {
    final cart = ref.watch(cartProvider);
    final cartItemIndex = cart.items.indexWhere((i) => i.name == item.name);
    final currentQty = cartItemIndex >= 0 ? cart.items[cartItemIndex].quantity : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEDDC3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.network(
              item.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.name} (${item.chineseName})',
                        style: AppTextStyles.labelMd.copyWith(fontSize: 15),
                      ),
                      Text(
                        _formatRupiah(item.price),
                        style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (currentQty > 0) ...[
                        GestureDetector(
                          onTap: () {
                            ref.read(cartProvider.notifier).removeItem(item.name);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.remove, size: 16, color: AppColors.primary),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            currentQty.toString(),
                            style: AppTextStyles.labelMd.copyWith(color: AppColors.onBackground),
                          ),
                        ),
                      ],
                      GestureDetector(
                        onTap: () {
                          ref.read(cartProvider.notifier).addItem(item);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.add, size: 16, color: AppColors.onPrimary),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFrozenBentoGrid() {
    return Column(
      children: [
        // Large Card (Family Pack Bundle)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                frozenItems[0].name,
                style: AppTextStyles.labelMd.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 2),
              Text(
                frozenItems[0].description,
                style: AppTextStyles.bodySm,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatRupiah(frozenItems[0].price),
                    style: AppTextStyles.headlineMd.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.onSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      ref.read(cartProvider.notifier).addItem(frozenItems[0]);
                    },
                    child: Text('Tambah Paket', style: AppTextStyles.labelMd.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Two Grid Cards
        Row(
          children: [
            Expanded(
              child: _buildFrozenGridCard(frozenItems[1]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFrozenGridCard(frozenItems[2]),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFrozenGridCard(CartItem item) {
    final cart = ref.watch(cartProvider);
    final cartItemIndex = cart.items.indexWhere((i) => i.name == item.name);
    final currentQty = cartItemIndex >= 0 ? cart.items[cartItemIndex].quantity : 0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.ac_unit, color: AppColors.primary, size: 36),
          const SizedBox(height: 8),
          Text(
            item.name,
            style: AppTextStyles.labelMd.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            _formatRupiah(item.price),
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentQty > 0) ...[
                GestureDetector(
                  onTap: () => ref.read(cartProvider.notifier).removeItem(item.name),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.remove, size: 16, color: AppColors.primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    currentQty.toString(),
                    style: AppTextStyles.labelMd,
                  ),
                ),
              ],
              GestureDetector(
                onTap: () => ref.read(cartProvider.notifier).addItem(item),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 16, color: AppColors.onPrimary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCartBottomBar(CartState cart) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.shopping_basket, color: Colors.white),
                  ),
                  Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cart.totalItems.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${cart.totalItems} item di keranjang',
                    style: AppTextStyles.labelSm.copyWith(color: Colors.white),
                  ),
                  Text(
                    _formatRupiah(cart.subtotal),
                    style: AppTextStyles.headlineMd.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () => context.push('/checkout'),
            child: Text(
              'Bayar Sekarang',
              style: AppTextStyles.labelMd.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Beranda', false, () => context.push('/')),
          _buildNavItem(Icons.receipt_long, 'Pesanan', true, () {}),
          _buildNavItem(Icons.shopping_basket, 'Keranjang', false, () {}),
          _buildNavItem(Icons.person, 'Profil', false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.onSecondaryContainer, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSecondaryContainer,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.onSurfaceVariant),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
