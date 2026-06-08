import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/assets/app_assets.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';
import 'package:dimsumnuraosxpress/features/orders/state/order_provider.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  int _merchantRating = 0;
  int _driverRating = 0;
  String _selectedTip = '';
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderProvider);
    if (order == null || order.status != OrderStatus.completed) {
      return Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => context.go('/tracking', extra: -1),
          ),
          title: Text(
            'Rating',
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.primary,
              fontSize: 18,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock_clock,
                  color: AppColors.primary,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'Rating belum tersedia',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headlineMd.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  'Anda bisa memberi rating setelah status pesanan selesai.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 22),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => context.go('/tracking', extra: -1),
                  child: const Text('Lihat Pesanan'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Detail\nPesanan',
          textAlign: TextAlign.center,
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.onSurface),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
            color: AppColors.outlineVariant.withValues(alpha: 0.1),
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Illustration Section
            _buildHeroSection(),

            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Rating Section
                  _buildRatingSection(),
                  const SizedBox(height: 20),

                  // Tipping Section
                  _buildTippingSection(),
                  const SizedBox(height: 24),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: AppColors.primary.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        ref.read(orderProvider.notifier).markRated();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Terima kasih atas penilaian Anda!'),
                          ),
                        );
                        context.go('/tracking', extra: -1);
                      },
                      child: Text(
                        'Kembali ke Beranda',
                        style: AppTextStyles.labelMd.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Glow
        Positioned(
          top: -40,
          child: Container(
            width: 320,
            height: 240,
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Digital Steamer Basket Image
              Image.asset(
                AppAssets.dimsumDeliveryHero,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Image.network(
                AppAssets.xpressWordmark,
                height: 18,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Text(
                'Selamat menikmati dimsum Anda!',
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineLg.copyWith(
                  fontSize: 24,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pesanan Anda dari Dimsum Nuraos telah tiba dalam keadaan hangat dan segar.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nilai Pengalaman Anda',
            style: AppTextStyles.labelMd.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Merchant Rating
          _buildRatingRow(
            icon: Icons.storefront,
            title: 'Dimsum Nuraos',
            tag: 'Mitra',
            rating: _merchantRating,
            onRatingChanged: (val) {
              setState(() {
                _merchantRating = val;
              });
            },
          ),
          const SizedBox(height: 20),
          Divider(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
          const SizedBox(height: 12),

          // Driver Rating
          _buildRatingRow(
            icon: Icons.delivery_dining,
            title: 'Budi',
            tag: 'Pengemudi',
            rating: _driverRating,
            onRatingChanged: (val) {
              setState(() {
                _driverRating = val;
              });
            },
          ),
          const SizedBox(height: 20),

          // Comments Area
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Bagikan masukan Anda...',
              hintStyle: AppTextStyles.bodySm,
              fillColor: AppColors.surfaceContainerLow,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1,
                ),
              ),
            ),
            style: AppTextStyles.bodyMd,
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow({
    required IconData icon,
    required String title,
    required String tag,
    required int rating,
    required Function(int) onRatingChanged,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: AppTextStyles.labelMd.copyWith(fontSize: 15),
                ),
              ],
            ),
            Text(
              tag,
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final starNum = index + 1;
            final isFilled = starNum <= rating;
            return GestureDetector(
              onTap: () => onRatingChanged(starNum),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  isFilled ? Icons.star : Icons.star_border,
                  color: isFilled
                      ? AppColors.primary
                      : AppColors.outlineVariant,
                  size: 36,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTippingSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tambah Tip untuk Pengemudi',
                style: AppTextStyles.labelMd.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.volunteer_activism,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTipButton('2000', 'Rp 2.000')),
              const SizedBox(width: 12),
              Expanded(child: _buildTipButton('5000', 'Rp 5.000')),
              const SizedBox(width: 12),
              Expanded(child: _buildTipButton('custom', 'Kustom')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipButton(String val, String text) {
    final bool isSelected = _selectedTip == val;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.primary : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : AppColors.onSurface,
        side: BorderSide(
          color: isSelected ? Colors.transparent : AppColors.outlineVariant,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: () {
        setState(() {
          _selectedTip = val;
        });
      },
      child: Text(
        text,
        style: AppTextStyles.labelMd.copyWith(
          color: isSelected ? Colors.white : AppColors.onSurface,
          fontSize: 13,
        ),
      ),
    );
  }
}
