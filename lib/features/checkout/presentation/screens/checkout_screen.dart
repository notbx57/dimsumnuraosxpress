import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';
import 'package:dimsumnuraosxpress/features/orders/state/order_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen>
    with SingleTickerProviderStateMixin {
  static const double deliveryFee = 12000;
  static const double serviceFee = 2500;

  late final AnimationController _routeController;
  String selectedPayment = 'Dompet Digital';

  @override
  void initState() {
    super.initState();
    _routeController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _routeController.dispose();
    super.dispose();
  }

  String _formatRupiah(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final totalPayment = cart.subtotal + deliveryFee + serviceFee;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Konfirmasi Pesanan',
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/cart'),
        ),
      ),
      body: cart.items.isEmpty
          ? _buildEmptyCheckout(context)
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 128),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRouteMap(cart),
                  const SizedBox(height: 20),
                  _buildOrderSummary(cart),
                  const SizedBox(height: 20),
                  _buildPaymentMethods(),
                  const SizedBox(height: 20),
                  _buildCostBreakdown(cart.subtotal, totalPayment),
                ],
              ),
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : _buildPaymentFooter(context, cart, totalPayment),
    );
  }

  Widget _buildEmptyCheckout(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_basket_outlined,
              color: AppColors.primary,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada menu untuk dipesan',
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineMd.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              'Tambahkan item ke keranjang sebelum masuk checkout.',
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
              onPressed: () => context.go('/menu'),
              child: const Text('Lihat Menu'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteMap(CartState cart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estimasi Driver',
          style: AppTextStyles.headlineMd.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 12),
        Container(
          height: 245,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3EA),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: AnimatedBuilder(
              animation: _routeController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _CheckoutMapPainter(_routeController.value),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 18,
                        child: _MapInfoPill(
                          icon: Icons.delivery_dining,
                          text: 'Driver 1.2 km dari toko',
                        ),
                      ),
                      Positioned(
                        left: 24,
                        bottom: 18,
                        right: 24,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.storefront,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      cart.items.first.merchantName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.labelMd,
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Toko -> Rumah: 3.4 km - estimasi 18 menit',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodySm.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(CartState cart) {
    return _SectionCard(
      title: 'Ringkasan Menu',
      child: Column(
        children: [
          for (final item in cart.items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      '${item.quantity}x',
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.labelMd,
                        ),
                        Text(
                          item.merchantName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _formatRupiah(item.price * item.quantity),
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Jl. Mawar Indah No. 42, Kebayoran Lama',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    final options = [
      (
        icon: Icons.account_balance_wallet,
        title: 'Dompet Digital',
        subtitle: 'Saldo Rp 150.000',
      ),
      (
        icon: Icons.credit_card,
        title: 'Kartu Debit/Kredit',
        subtitle: 'Visa **** 4242',
      ),
      (
        icon: Icons.payments,
        title: 'Bayar di Tempat',
        subtitle: 'Siapkan uang pas',
      ),
    ];

    return _SectionCard(
      title: 'Metode Pembayaran',
      child: Column(
        children: [
          for (final option in options)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PaymentOption(
                icon: option.icon,
                title: option.title,
                subtitle: option.subtitle,
                isSelected: selectedPayment == option.title,
                onTap: () => setState(() => selectedPayment = option.title),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown(double subtotal, double totalPayment) {
    return _SectionCard(
      title: 'Total Harga',
      child: Column(
        children: [
          _CostRow(label: 'Subtotal menu', value: _formatRupiah(subtotal)),
          const SizedBox(height: 8),
          _CostRow(label: 'Ongkos kirim', value: _formatRupiah(deliveryFee)),
          const SizedBox(height: 8),
          _CostRow(label: 'Biaya layanan', value: _formatRupiah(serviceFee)),
          const SizedBox(height: 12),
          Divider(color: AppColors.outlineVariant.withValues(alpha: 0.35)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total bayar',
                style: AppTextStyles.labelMd.copyWith(fontSize: 16),
              ),
              Text(
                _formatRupiah(totalPayment),
                style: AppTextStyles.headlineMd.copyWith(
                  color: AppColors.primary,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentFooter(
    BuildContext context,
    CartState cart,
    double totalPayment,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total pembayaran', style: AppTextStyles.bodySm),
                  Text(
                    _formatRupiah(totalPayment),
                    style: AppTextStyles.headlineMd.copyWith(
                      color: AppColors.primary,
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                onPressed: () {
                  ref
                      .read(orderProvider.notifier)
                      .createFromCart(
                        cart: cart,
                        deliveryFee: deliveryFee,
                        serviceFee: serviceFee,
                        paymentMethod: selectedPayment,
                      );
                  ref.read(cartProvider.notifier).clear();
                  context.go('/tracking', extra: 1);
                },
                icon: const Icon(Icons.lock),
                label: Text(
                  'Bayar',
                  style: AppTextStyles.labelMd.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headlineMd.copyWith(fontSize: 20)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.35),
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryContainer.withValues(alpha: 0.55)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.outlineVariant.withValues(alpha: 0.25),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.labelMd),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _CostRow extends StatelessWidget {
  const _CostRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMd),
        Text(value, style: AppTextStyles.bodyMd),
      ],
    );
  }
}

class _MapInfoPill extends StatelessWidget {
  const _MapInfoPill({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 16),
          const SizedBox(width: 6),
          Text(text, style: AppTextStyles.labelSm),
        ],
      ),
    );
  }
}

class _CheckoutMapPainter extends CustomPainter {
  const _CheckoutMapPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.82)
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final thinRoadPaint = Paint()
      ..color = const Color(0xFFC9DDCE)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final y in [0.22, 0.46, 0.72]) {
      canvas.drawLine(
        Offset(0, size.height * y),
        Offset(size.width, size.height * (y + 0.08)),
        roadPaint,
      );
    }
    for (final x in [0.22, 0.50, 0.78]) {
      canvas.drawLine(
        Offset(size.width * x, 0),
        Offset(size.width * (x - 0.12), size.height),
        roadPaint,
      );
    }

    final driverStart = Offset(size.width * 0.16, size.height * 0.28);
    final merchant = Offset(size.width * 0.50, size.height * 0.42);
    final user = Offset(size.width * 0.80, size.height * 0.70);

    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(driverStart.dx, driverStart.dy)
      ..quadraticBezierTo(
        size.width * 0.34,
        size.height * 0.18,
        merchant.dx,
        merchant.dy,
      )
      ..quadraticBezierTo(
        size.width * 0.68,
        size.height * 0.56,
        user.dx,
        user.dy,
      );

    canvas.drawPath(path, routePaint);
    canvas.drawPath(path, thinRoadPaint);

    final driver = _pointOnPath(path, progress);
    _drawMarker(canvas, driverStart, AppColors.secondary, Icons.near_me);
    _drawMarker(canvas, merchant, AppColors.primary, Icons.storefront);
    _drawMarker(canvas, user, AppColors.onBackground, Icons.home);
    _drawMarker(canvas, driver, const Color(0xFF0E9F6E), Icons.motorcycle);
  }

  Offset _pointOnPath(Path path, double t) {
    final metric = path.computeMetrics().first;
    final tangent = metric.getTangentForOffset(metric.length * t);
    return tangent?.position ?? Offset.zero;
  }

  void _drawMarker(Canvas canvas, Offset center, Color color, IconData icon) {
    final markerPaint = Paint()..color = Colors.white;
    final accentPaint = Paint()..color = color;
    canvas.drawCircle(center, 18, markerPaint);
    canvas.drawCircle(center, 13, accentPaint);

    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          color: Colors.white,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: 15,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    iconPainter.paint(
      canvas,
      center - Offset(iconPainter.width / 2, iconPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _CheckoutMapPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
