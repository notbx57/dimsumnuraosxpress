import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/assets/app_assets.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.primary),
          onPressed: () {},
        ),
        title: Text(
          'Dimsum Nuraos',
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
                color: AppColors.secondaryContainer,
                border: Border.all(color: AppColors.primaryLight, width: 2),
                image: const DecorationImage(
                  image: NetworkImage(AppAssets.profileAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Section
              _buildSearchSection(),
              const SizedBox(height: 24),

              // Promo Hangat Section
              _buildSectionHeader(context, 'Promo Hangat', () {}),
              const SizedBox(height: 12),
              _buildPromoCarousel(),
              const SizedBox(height: 24),

              // Terlaris Section
              _buildSectionHeader(context, 'Terlaris', () {}),
              const SizedBox(height: 12),
              _buildBestSellers(),
              const SizedBox(height: 24),

              // Mitra Terdekat Section
              _buildSectionHeader(
                context,
                'Mitra Terdekat',
                () {},
                showFilter: true,
              ),
              const SizedBox(height: 12),
              _buildNearbyMerchants(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          elevation: 6,
          onPressed: () => context.push('/menu'),
          child: const Icon(
            Icons.restaurant_menu,
            color: AppColors.onPrimary,
            size: 28,
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              children: [
                SizedBox(width: 16),
                Icon(Icons.search, color: AppColors.onSurfaceVariant),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari dimsum disini aja!',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontFamily: 'Be Vietnam Pro',
                        fontSize: 16,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            icon: const Icon(Icons.tune, color: AppColors.onPrimary),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback onSeeAll, {
    bool showFilter = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineMd.copyWith(
            color: AppColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (showFilter)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.filter_list,
              color: AppColors.primary,
              size: 20,
            ),
          )
        else
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'Lihat Semua',
              style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
            ),
          ),
      ],
    );
  }

  Widget _buildPromoCarousel() {
    final List<Map<String, String>> promos = [
      {
        'title': 'Diskon 20% untuk Dimsum Ayam',
        'subtitle': 'Berlaku sampai tengah malam • Dimsum Nuraos',
        'tag': 'PENAWARAN TERBATAS',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDRiZcQvE42wn0W6GvNyYzce3EkVh6BJ9SrmGBDotAQQOIAJ6JZ3syfnhEQSrXepe0S1e3snXyXP0iv3j7NHDp9TEu8FLB2RigtgknmaUzZy1aVskWnaBR4f-jRJWp8FuhNfLP7tKws3um9bmKPebYF7JLBcnB1fjT03348hoZolCWgN7pF7xM3Kg1GNSSC9p0BcOvF_amV1T05D2BFu7MZBldnO7LZEcmIIpmpFhP7Pw8HD7gF5CxvblTGUwHo8WWUwmYB9mWPmRw',
        'tagBg': '0xFF9E3D00',
        'tagFg': '0xFFFFFFFF',
      },
      {
        'title': 'Siomay Udang Premium',
        'subtitle': 'Coba resep baru kami hari ini!',
        'tag': 'BARU DATANG',
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCujCzKCpy0mOStvUqevVVzDnfR-rMhbNKBNFIx9EEP5uiNwT07KUza6rY8LxgAzqlEoLsMB2tnonhESc4oEgt4Y6ABjigsHqS943C-YiIlNEtadjZWYIPpXHLOWw3t0Lqa7gvNHGatbXihSgMtMHZGTrSbOXtnhnjc8ud8eh1BzZBVBGuZFXj0Xb-k2VAnfYN60KPHx1_aGx0rnjwnpVY6t_VqGacFxAea2AwlQ1nbI8TdcQX7YCDdak4AHTjTXfInXNd6Et0kVrc',
        'tagBg': '0xFF8C7042',
        'tagFg': '0xFFFFFBFF',
      },
    ];

    return SizedBox(
      height: 192,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: promos.length,
        itemBuilder: (context, index) {
          final promo = promos[index];
          return Container(
            width: 320,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(promo['image']!),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(int.parse(promo['tagBg']!)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      promo['tag']!,
                      style: const TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    promo['title']!,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    promo['subtitle']!,
                    style: TextStyle(
                      fontFamily: 'Be Vietnam Pro',
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBestSellers() {
    final List<Map<String, dynamic>> items = [
      {
        'name': 'Siomay Ayam Spesial',
        'merchant': 'Dimsum Nuraos Xpress',
        'rating': 4.9,
        'price': 25000.0,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDRiZcQvE42wn0W6GvNyYzce3EkVh6BJ9SrmGBDotAQQOIAJ6JZ3syfnhEQSrXepe0S1e3snXyXP0iv3j7NHDp9TEu8FLB2RigtgknmaUzZy1aVskWnaBR4f-jRJWp8FuhNfLP7tKws3um9bmKPebYF7JLBcnB1fjT03348hoZolCWgN7pF7xM3Kg1GNSSC9p0BcOvF_amV1T05D2BFu7MZBldnO7LZEcmIIpmpFhP7Pw8HD7gF5CxvblTGUwHo8WWUwmYB9mWPmRw',
      },
      {
        'name': 'Hakau Udang',
        'merchant': 'Golden Steam',
        'rating': 4.8,
        'price': 32000.0,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCi4pQhFrCXDBWosMQxYLUsg3K5Do5A_DB_HLQiyeBU6bQRkfFoBXb5qst8VKWkXD3HjA9Zxff2mkE3lo36iHs2iaIw-yVY9Psru5Gq7YsnJHnUrNg9Y-NDKT2JgnOHJl86O8yGHXErou-DV89WBKva10LF-oeDPYMNKBu3dVb1eAIo83uhSczY4C80xdHs0zNW2QxDezbLLZaFssYBv8sGme8sioWGUg8pbz72jQsv3U71SWJ0o2Q1e35SNb2w1QiZY-xrSIBZGtA',
      },
      {
        'name': 'Dimsum Sapi',
        'merchant': 'Hao Chi Dimsum',
        'rating': 4.7,
        'price': 28000.0,
        'image':
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCKZw8Eufa3_e1QhhaEek5J-_8lp4bvW38Q_NV03V9-Fxgsrh00hWRXjad_s8-UqVflErt9qBigdOty6zTEQmtZXJZXheXj8czv6R4QTc0wNjNODB72yUDeQmHB8HC0yQgJxq2j6sMwEETrRmfVuR1x_rZZSH6bePzrt3hf1wPbrXAUQz0m7WJ6XQel02kFxqeH_oJ-C5zMBiZltpUPQHf_nt2aDU_ujhT6xo4yDDVWKRv-EMwmRgzxyfltq7wRZAC9jQ40HuG1TAI',
      },
    ];

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => context.push('/menu'),
            child: Container(
              width: 180,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          item['image']!,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                item['rating'].toString(),
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.labelMd.copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['merchant'] == 'Dimsum Nuraos Xpress'
                              ? 'Dimsum Nuraos'
                              : item['merchant']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySm.copyWith(fontSize: 11),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rp ${(item['price'] as double).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                              style: AppTextStyles.labelMd.copyWith(
                                color: AppColors.primary,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColors.primary,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNearbyMerchants(BuildContext context) {
    return Column(
      children: [
        // Hero Merchant Card (Dimsum Nuraos Xpress)
        GestureDetector(
          onTap: () => context.push('/menu'),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.network(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuD8uVW4KbsPFtT7ZihWVazX_IBPV_QnlUL8_Ri0YZmWsK9JwMK4xnQvo-6RSqTJpZ-JDh1_rraneVZT-33TbpICV6aYvl1VyMg-IqniAsTshmzUblpez99H-zeZTYdTXySuDmKBkSMVnFiHA53Oj2EL5Vdu3couOla6IQtBhbk9punZqopa9QvOUD64uoPn6cFL0MpNaqbTEGmuwpIpif4HJeK7F8-sbvNSWbvzj6O78xMemy35xvvMC82UJIQ_yqGxftbXL0KjIwM',
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Dimsum Nuraos',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.headlineMd.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Image.network(
                                  AppAssets.xpressWordmark,
                                  height: 28,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.favorite_border,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Dimsum kukus bambu artisanal dengan isian premium. Terkenal dengan 4 varian khas: Ayam, Sapi, Udang, dan Keju.',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          _buildTag('Pengiriman Cepat'),
                          _buildTag('HALAL'),
                          _buildTag('Autentik'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 1,
                        color: AppColors.outlineVariant.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.onSurfaceVariant,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '0.8 km jauhnya',
                                style: AppTextStyles.labelMd.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.onPrimary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () => context.push('/menu'),
                            child: Text(
                              'Pesan Sekarang',
                              style: AppTextStyles.labelMd.copyWith(
                                color: AppColors.onPrimary,
                              ),
                            ),
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
        const SizedBox(height: 16),

        // Grid of Other Merchants
        Row(
          children: [
            Expanded(
              child: _buildSecondaryMerchantCard(
                'Hao Chi Dimsum',
                'Pangsit & Bakpao',
                '4.5',
                'Ongkir Murah',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCkzfvu51S9v3BpC8jZ2IroBqjO142BEju76xA07iPmV9wbkS2qNGryAjQ8wNBUEaNtcAC0D7AbDfJImCC2GvNIzAwA-TKm2RuqUfNkc17yLk2mEq0bl7VDfUABpqautXtYPsk9Di3qXqD5khk1Weg7QOeAi0QS99MR3hlZef3jH2iMm2h3uFHmFu3cjQ5sO7WnfuK5mFv0KcdOj2ZRdD4iNXQSDfVHA86eU6F4ZSmKxghx9ig003MFowjRw3XU4bv3QbQEmsRJfYs',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSecondaryMerchantCard(
                'Golden Steam',
                'Kanton Modern',
                '4.7',
                'Gratis Ongkir',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAfbZ7sF8QF2OYcMDPZrQNZqvRDdjbLTdlFyfjyvkpMeoaR2ysAMAuT7E6svTWGhJ3tsQ4IkjWwAH2LdWg2YpZiu9sLCtLGhkDb767RpIAY4r2sdtRa4DHD3lwlt0lnnY9fbT5MXMLlLC-_km6QIVVMHvjWgSdHOr15Ule08Nw_OUJjEvJsA-b3HIzTZRU-mmuvGMpwIqLOO2uQpFyXbrwt0zNPDXDCz9MzjCjXToyopWe3r8-QMlTbeCF1TbGF90xIlQYoTatKGuI',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: AppColors.onSurfaceVariant,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildSecondaryMerchantCard(
    String name,
    String category,
    String rating,
    String promo,
    String image,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelMd.copyWith(fontSize: 13),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.primary,
                          size: 12,
                        ),
                        const SizedBox(width: 1),
                        Text(
                          rating,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  category,
                  style: TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  promo,
                  style: const TextStyle(
                    fontFamily: 'Be Vietnam Pro',
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Beranda', true, () {}),
          _buildNavItem(
            Icons.receipt_long,
            'Pesanan',
            false,
            () => context.push('/tracking'),
          ),
          _buildNavItem(
            Icons.shopping_basket,
            'Keranjang',
            false,
            () => context.push('/menu'),
          ),
          _buildNavItem(Icons.person, 'Profil', false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
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
            ),
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
          ),
        ],
      ),
    );
  }
}
