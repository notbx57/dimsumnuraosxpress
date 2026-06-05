import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectedPayment = 'wallet';

  String _formatRupiah(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    // If cart is empty, let's mock items as in the HTML design to show a rich UI
    final List<CartItem> displayItems = cart.items.isNotEmpty
        ? cart.items
        : [
            CartItem(
              name: 'Ayam',
              chineseName: '鸡',
              price: 24000.0,
              quantity: 2,
              image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC8zRB7fnGTSyEiCsaA3XXGHgstmE3StecrJJWiVpg1awbnuj_-etsJsuBbmRqQC1aawrBo4h3DERWxdYeXPh2TiVZ7RodVheFWy7Xw9NLqnnR85WzWMU18V6FSOmGp-HqtOLqvyHl94lFf_YlsiJlRQ46547t6XCxMaLJruAzViqOdgIcZA-ly5SGvQIt2z4crYcszJvYb-fGQsT25jMQIzrczYVuwJ9cs66BG5ji3DF9VovYvpbd5DAltrz-Y50WK8-2OKJD6cU0',
              description: '',
            ),
            CartItem(
              name: 'Keju',
              chineseName: '芝士',
              price: 26000.0,
              quantity: 1,
              image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCIG5ZsaZWVqSnlSJ5zngYOFAJx1hTOPxiZa6o3qS9e6XyBdoJ6VipYgy6arQmxxdBXK00qkmGVt4UC0_5a6ct6HgCKIpU8fBoEygNJzrVqC0Ebm39aYB8tIcnbtvtpqlYbB_xp6mc8m9weAUab6O_YXAUGBerUE-mDJxa56TUsI3u3evWmnxkZgdYy1g684QWupQ1RDrKGrESpvioiBmmzf6EwX2_1hsH9tKX9VYl89hbeHoHBpgBAQZSscVB9BqFnFqEsWBbGBM8',
              description: '',
            )
          ];

    final double subtotal = cart.items.isNotEmpty
        ? cart.subtotal
        : displayItems.fold(0, (sum, i) => sum + (i.price * i.quantity));

    const double deliveryFee = 12000.0;
    const double serviceFee = 2500.0;
    final double totalPayment = subtotal + deliveryFee + serviceFee;

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
                border: Border.all(color: AppColors.primaryLight, width: 2),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Section
              _buildAddressSection(),
              const SizedBox(height: 24),

              // Order Summary Section
              _buildOrderSummary(displayItems),
              const SizedBox(height: 24),

              // Payment Method Section
              _buildPaymentMethodSection(),
              const SizedBox(height: 24),

              // Summary Cost Breakdown Section
              _buildCostBreakdown(subtotal, deliveryFee, serviceFee, totalPayment),
              const SizedBox(height: 120), // spacer for sticky footer
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildStickyFooter(totalPayment),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Alamat Pengiriman',
              style: AppTextStyles.headlineMd.copyWith(
                color: AppColors.onBackground,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Ubah',
                style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: AppColors.primary, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rumah',
                          style: AppTextStyles.labelMd.copyWith(fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Jl. Mawar Indah No. 42, Kebayoran Lama, Jakarta Selatan 12240',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              // Mini map preview
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDPaPCmEtL_4HGMNsyTyYRt8jioTxdmiC08FUvBODgtW2wV0oDX6uas2maF1C2fakZYZdxM_l87cBo5Ys-t6PL1hIuhtT_dAQ-H9s52UGtDQNHwqvHvY3ln_fnchtLSCeZQLmg27dU1O4HlJhytBahRqLh9Zkrr8S3Kkj-6H82orQX3TzWZFQFFqTBjutbt8akehXn2I_7hxoKimVXsbMvGRj6-FPMfXi6Dd37QBOflVrDYuW6XbyxfiBG3usYUjjI1wbdnIr3LP04',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: const Icon(Icons.location_on, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOrderSummary(List<CartItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Pesanan',
          style: AppTextStyles.headlineMd.copyWith(
            color: AppColors.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: AppColors.outlineVariant.withValues(alpha: 0.2),
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(item.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
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
                                _formatRupiah(item.price * item.quantity),
                                style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.quantity}x Porsi',
                            style: AppTextStyles.bodySm,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metode Pembayaran',
          style: AppTextStyles.headlineMd.copyWith(
            color: AppColors.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            // E-wallet
            _buildPaymentOption(
              'wallet',
              Icons.account_balance_wallet,
              'Dompet Digital (OVO/GoPay)',
              subtitle: 'Saldo: Rp 150.000',
            ),
            const SizedBox(height: 12),
            // Credit Card
            _buildPaymentOption(
              'card',
              Icons.credit_card,
              'Kartu Kredit',
              subtitle: '**** **** **** 4242',
            ),
            const SizedBox(height: 12),
            // COD
            _buildPaymentOption(
              'cod',
              Icons.payments,
              'Bayar di Tempat (COD)',
            ),
          ],
        )
      ],
    );
  }

  Widget _buildPaymentOption(String value, IconData icon, String title, {String? subtitle}) {
    final bool isSelected = selectedPayment == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryContainer.withValues(alpha: 0.3)
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outlineVariant.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.labelMd.copyWith(fontSize: 14),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySm.copyWith(
                        color: isSelected ? AppColors.onSecondaryContainer : AppColors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCostBreakdown(double subtotal, double delivery, double service, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.tertiaryFixed.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildCostRow('Subtotal', _formatRupiah(subtotal)),
          const SizedBox(height: 8),
          _buildCostRow('Ongkos Kirim', _formatRupiah(delivery)),
          const SizedBox(height: 8),
          _buildCostRow('Biaya Layanan', _formatRupiah(service)),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                style: AppTextStyles.headlineMd.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                _formatRupiah(total),
                style: AppTextStyles.headlineMd.copyWith(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildStickyFooter(double total) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.85),
        border: Border(top: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.3))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Pembayaran',
                style: AppTextStyles.bodySm,
              ),
              Text(
                _formatRupiah(total),
                style: AppTextStyles.headlineMd.copyWith(
                  color: AppColors.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.confirmation_number, color: AppColors.secondary, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'Promo Diterapkan',
                    style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary, fontSize: 10),
                  ),
                ],
              )
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              elevation: 4,
              shadowColor: AppColors.primary.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            onPressed: () {
              // Clear cart on successful order
              ref.read(cartProvider.notifier).clear();
              // Navigate to tracking
              context.push('/tracking');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pesan Sekarang',
                  style: AppTextStyles.labelMd.copyWith(color: AppColors.onPrimary, fontSize: 16),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.rocket_launch, color: AppColors.onPrimary, size: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
