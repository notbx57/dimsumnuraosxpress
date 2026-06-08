import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';
import 'package:dimsumnuraosxpress/core/widgets/app_bottom_nav.dart';
import 'package:dimsumnuraosxpress/features/orders/state/order_provider.dart';

class TrackingScreen extends ConsumerStatefulWidget {
  const TrackingScreen({super.key});

  @override
  ConsumerState<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends ConsumerState<TrackingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _showMap = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 16),
      vsync: this,
    )..addListener(_syncStatusWithProgress);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _configureAnimationForOrder(ref.read(orderProvider));
    });
  }

  @override
  void dispose() {
    _animationController
      ..removeListener(_syncStatusWithProgress)
      ..dispose();
    super.dispose();
  }

  void _syncStatusWithProgress() {
    final order = ref.read(orderProvider);
    if (order == null || order.status == OrderStatus.completed) return;

    final progress = _animationController.value;
    if (progress < 0.38) {
      ref
          .read(orderProvider.notifier)
          .updateStatus(OrderStatus.driverToMerchant);
    } else if (progress < 1) {
      ref.read(orderProvider.notifier).updateStatus(OrderStatus.driverToUser);
    }
  }

  String _formatRupiah(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ActiveOrder?>(orderProvider, (_, next) {
      _configureAnimationForOrder(next);
    });

    final order = ref.watch(orderProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _showMap ? 'Live Map' : 'Pesanan',
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            if (_showMap) {
              setState(() => _showMap = false);
              return;
            }
            context.canPop() ? context.pop() : context.go('/');
          },
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 320),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.04, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(order == null ? 'empty' : (_showMap ? 'map' : 'list')),
          child: order == null
              ? _buildEmptyOrder(context)
              : _showMap
              ? _buildTracking(context, order)
              : _buildOrderList(context, order),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(activeTab: AppTab.orders),
    );
  }

  void _configureAnimationForOrder(ActiveOrder? order) {
    if (order == null) {
      _animationController.stop();
      return;
    }

    if (order.status == OrderStatus.completed) {
      _animationController
        ..stop()
        ..value = 1;
      return;
    }

    final minimumProgress = switch (order.status) {
      OrderStatus.empty ||
      OrderStatus.paid ||
      OrderStatus.driverToMerchant => 0.0,
      OrderStatus.driverToUser => 0.38,
      OrderStatus.completed => 1.0,
    };

    if (_animationController.value < minimumProgress) {
      _animationController.value = minimumProgress;
    }

    if (_animationController.isAnimating) return;

    _animationController.forward().whenComplete(() {
      if (!mounted) return;
      ref.read(orderProvider.notifier).updateStatus(OrderStatus.completed);
    });
  }

  Widget _buildEmptyOrder(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                color: AppColors.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: AppColors.primary,
                size: 42,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Belum ada pesanan aktif',
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineMd.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 8),
            Text(
              'Pesanan yang sudah dibayar akan muncul di sini bersama posisi driver.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTracking(BuildContext context, ActiveOrder order) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final progress = order.status == OrderStatus.completed
            ? 1.0
            : _animationController.value;

        return Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _TrackingMapPainter(progress),
                child: Container(color: const Color(0xFFEAF3EA)),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 16,
              child: _OrderHeaderCard(
                orderId: order.orderId,
                statusText: _statusText(order.status),
                eta: _etaText(order.status, progress),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: _DriverStatusCard(
                order: order,
                progress: progress,
                statusText: _statusText(order.status),
                total: _formatRupiah(order.total),
                canRate:
                    order.status == OrderStatus.completed && !order.hasRated,
                hasRated: order.hasRated,
                onRate: () => context.push('/review'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOrderList(BuildContext context, ActiveOrder order) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final progress = order.status == OrderStatus.completed
            ? 1.0
            : _animationController.value;

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: [
            _OrderListCard(
              order: order,
              statusText: _statusText(order.status),
              eta: _etaText(order.status, progress),
              total: _formatRupiah(order.total),
              onTap: () => setState(() => _showMap = true),
            ),
          ],
        );
      },
    );
  }

  String _statusText(OrderStatus status) {
    return switch (status) {
      OrderStatus.empty => 'Belum ada pesanan',
      OrderStatus.paid => 'Pembayaran berhasil',
      OrderStatus.driverToMerchant => 'Driver menuju toko mitra',
      OrderStatus.driverToUser => 'Driver menuju alamat Anda',
      OrderStatus.completed => 'Pesanan selesai',
    };
  }

  String _etaText(OrderStatus status, double progress) {
    if (status == OrderStatus.completed) return 'Selesai';
    final eta = (18 - (progress * 17)).clamp(1, 18).round();
    return '$eta mnt';
  }
}

class _OrderListCard extends StatelessWidget {
  const _OrderListCard({
    required this.order,
    required this.statusText,
    required this.eta,
    required this.total,
    required this.onTap,
  });

  final ActiveOrder order;
  final String statusText;
  final String eta;
  final String total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.45),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderId,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelMd.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        statusText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    eta,
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.onSecondaryContainer,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  for (final item in order.items)
                    _OrderItemRow(
                      name: item.name,
                      quantity: item.quantity,
                      price: item.price,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${order.totalItems} menu',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  total,
                  style: AppTextStyles.labelMd.copyWith(
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.map_outlined,
                  color: AppColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Lihat live map',
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.primary,
                  size: 22,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String name;
  final int quantity;
  final double price;

  String _formatRupiah(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$quantity',
              style: AppTextStyles.labelSm.copyWith(color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMd,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatRupiah(price * quantity),
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderHeaderCard extends StatelessWidget {
  const _OrderHeaderCard({
    required this.orderId,
    required this.statusText,
    required this.eta,
  });

  final String orderId;
  final String statusText;
  final String eta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: AppColors.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.delivery_dining, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.labelMd.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 3),
                Text(
                  orderId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            eta,
            style: AppTextStyles.headlineMd.copyWith(
              color: AppColors.primary,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverStatusCard extends StatelessWidget {
  const _DriverStatusCard({
    required this.order,
    required this.progress,
    required this.statusText,
    required this.total,
    required this.canRate,
    required this.hasRated,
    required this.onRate,
  });

  final ActiveOrder order;
  final double progress;
  final String statusText;
  final String total;
  final bool canRate;
  final bool hasRated;
  final VoidCallback onRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budi - T 1987 BC',
                      style: AppTextStyles.labelMd.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      statusText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Menghubungi driver...')),
                  );
                },
                icon: const Icon(Icons.call),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.surfaceContainer,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _MiniSummary(
                  label: '${order.totalItems} menu',
                  value: order.merchantName,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniSummary(label: 'Total', value: total),
              ),
            ],
          ),
          if (canRate || hasRated) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hasRated
                      ? AppColors.surfaceContainer
                      : AppColors.primary,
                  foregroundColor: hasRated
                      ? AppColors.onSurfaceVariant
                      : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: canRate ? onRate : null,
                icon: Icon(hasRated ? Icons.check_circle : Icons.star),
                label: Text(hasRated ? 'Rating terkirim' : 'Beri Rating'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniSummary extends StatelessWidget {
  const _MiniSummary({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.labelSm),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelMd.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _TrackingMapPainter extends CustomPainter {
  const _TrackingMapPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.86)
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final blockPaint = Paint()..color = const Color(0xFFD8E8DB);

    for (var i = 0; i < 7; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (i % 3) * size.width * 0.34 + 12,
            (i ~/ 3) * size.height * 0.22 + 92,
            size.width * 0.24,
            size.height * 0.12,
          ),
          const Radius.circular(18),
        ),
        blockPaint,
      );
    }

    for (final y in [0.28, 0.48, 0.68]) {
      canvas.drawLine(
        Offset(-20, size.height * y),
        Offset(size.width + 20, size.height * (y - 0.10)),
        roadPaint,
      );
    }
    for (final x in [0.20, 0.56, 0.86]) {
      canvas.drawLine(
        Offset(size.width * x, 0),
        Offset(size.width * (x - 0.18), size.height),
        roadPaint,
      );
    }

    final merchant = Offset(size.width * 0.34, size.height * 0.34);
    final user = Offset(size.width * 0.75, size.height * 0.62);
    final path = Path()
      ..moveTo(merchant.dx, merchant.dy)
      ..quadraticBezierTo(
        size.width * 0.53,
        size.height * 0.42,
        user.dx,
        user.dy,
      );
    final routePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, routePaint);

    final driver = _pointOnPath(path, progress);
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
    canvas.drawCircle(center, 22, Paint()..color = Colors.white);
    canvas.drawCircle(center, 16, Paint()..color = color);

    final painter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          color: Colors.white,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          fontSize: 18,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _TrackingMapPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
