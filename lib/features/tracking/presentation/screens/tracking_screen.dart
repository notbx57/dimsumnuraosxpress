import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dimsumnuraosxpress/core/assets/app_assets.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  int _etaMinutes = 12;
  String _driverStatus = 'Pengemudi sedang menjemput dimsum Anda';

  // Map coordinates (percentages of screen size)
  // Merchant: (30%, 25%)
  // Home: (75%, 70%)
  final Offset merchantOffset = const Offset(0.30, 0.25);
  final Offset homeOffset = const Offset(0.75, 0.70);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        )..addListener(() {
          setState(() {
            // Dynamic status and ETA updates as progress changes
            final progress = _progressAnimation.value;
            if (progress < 0.4) {
              _etaMinutes = 12 - (progress * 10).toInt();
              _driverStatus = 'Pengemudi sedang mengambil pesanan di toko';
            } else if (progress < 0.8) {
              _etaMinutes = 7 - ((progress - 0.4) * 12).toInt();
              _driverStatus =
                  'Pengemudi sedang di perjalanan menuju alamat Anda';
            } else {
              _etaMinutes = 2 - ((progress - 0.8) * 10).toInt();
              if (_etaMinutes < 1) _etaMinutes = 1;
              _driverStatus = 'Pengemudi sudah dekat dengan lokasi Anda';
            }
          });
        });

    _animationController.forward().then((_) {
      if (mounted) {
        setState(() {
          _etaMinutes = 0;
          _driverStatus = 'Pengemudi telah sampai di lokasi Anda!';
        });
        _showArrivalDialog();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showArrivalDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Pesanan Tiba!',
            style: AppTextStyles.headlineMd.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Dimsum hangat Anda sudah sampai di depan rumah. Selamat menikmati!',
            style: AppTextStyles.bodyMd,
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                context.push('/review'); // Go to review screen
              },
              child: Text(
                'Beri Penilaian',
                style: AppTextStyles.labelMd.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Linear interpolation between two coordinates
  Offset _getDriverPosition(double progress) {
    // We can add a slight curve to make it look realistic (Bézier-like)
    // Merchant (30%, 25%) -> Control point (55%, 35%) -> Home (75%, 70%)
    double t = progress;
    double x =
        (1 - t) * (1 - t) * merchantOffset.dx +
        2 * (1 - t) * t * 0.55 +
        t * t * homeOffset.dx;
    double y =
        (1 - t) * (1 - t) * merchantOffset.dy +
        2 * (1 - t) * t * 0.35 +
        t * t * homeOffset.dy;
    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
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
          'Lacak Pesanan - Dimsum Nuraos',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.primary,
            fontSize: 14,
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
                color: AppColors.primaryLight,
                border: Border.all(color: AppColors.primary, width: 2),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;

          // Get exact pixel offsets
          final Offset merchantPixel = Offset(
            merchantOffset.dx * width,
            merchantOffset.dy * height,
          );
          final Offset homePixel = Offset(
            homeOffset.dx * width,
            homeOffset.dy * height,
          );
          final Offset driverOffsetPercent = _getDriverPosition(
            _progressAnimation.value,
          );
          final Offset driverPixel = Offset(
            driverOffsetPercent.dx * width,
            driverOffsetPercent.dy * height,
          );

          return Stack(
            children: [
              // Map Background image (centered, cover)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.85,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBN7bGl4LefwBLwdEAhBD406B5RlUjbJcy5MzX_8z5cta544Ll7H1TRt3xOtk1aI1TDUowfH_YJ-pHPJg0WGi73tlCkuDAwfGaiNRYXDyH4d9Mf89Dwur0086UNHN7pONlt-HK2ZvWlwcF7JK3Ss5AfUz7pRKqvwhanrRyh0VNYkp51ah4uSC6M4jSEIdnWU8n7vTzUUWzGoKZAAUeL3NVrEdvwQk4H-1O1ajApI1_Pc5YuR8Tc6oT9bYQaJyFcaXpTlQ_q32OfCfU',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Map Gradient Overlays to match the web style
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.background.withValues(alpha: 0.8),
                        Colors.transparent,
                        Colors.transparent,
                        AppColors.background,
                      ],
                      stops: const [0.0, 0.2, 0.8, 1.0],
                    ),
                  ),
                ),
              ),

              // Path Custom Painter
              Positioned.fill(
                child: CustomPaint(
                  painter: _RoutePainter(merchantPixel, homePixel),
                ),
              ),

              // Merchant Marker
              Positioned(
                left: merchantPixel.dx - 50,
                top: merchantPixel.dy - 60,
                child: SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          'Dimsum Nuraos',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.labelSm.copyWith(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.restaurant,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // User Home Marker
              Positioned(
                left: homePixel.dx - 50,
                top: homePixel.dy - 60,
                child: SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.onBackground,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          'Rumah Anda',
                          style: AppTextStyles.labelSm.copyWith(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.home,
                          color: AppColors.onBackground,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Driver Marker (animating along route)
              Positioned(
                left: driverPixel.dx - 22,
                top: driverPixel.dy - 22,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.motorcycle,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),

              // Floating Driver Status Card
              Positioned(
                bottom: 24,
                left: 20,
                right: 20,
                child: _buildDriverCard(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDriverCard() {
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
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ETA Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimasi Tiba',
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _etaMinutes > 0 ? '$_etaMinutes mnt' : 'Sampai',
                    style: AppTextStyles.headlineMd.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColors.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.timer,
                  color: AppColors.onSecondaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: AppColors.outlineVariant.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 12),
          // Driver Info
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondaryContainer,
                        width: 2,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDX2IxKCdUuMcHsCt5uCkIObUOtVZwXEp829CmrSkQyCe-Mccxy9vUkasca0ZCvTDS2J8Pgkr-F0j8WG1YWTB7JPNargl-CRr8dJqjYTGfD_gL4IMYq8Uz9eqq7c9zbya3RTcjWKoT4LNB50rEkrucIJ3fn5sae_ZuDxTA4c4EGxCEstWtdYg4YrT0lwZgcTV4o9gQAUbKpT6lqccY2xm6vp10AGmkWnqPvyCHAF7hLItrBbj1UWV5S_E83Da6vzBhUjJReRooyXwY',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
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
                          'Budi',
                          style: AppTextStyles.labelMd.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'T 1987 BC',
                            style: AppTextStyles.labelSm.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _driverStatus,
                      style: AppTextStyles.bodySm.copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Menghubungi Chat Budi...')),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chat, size: 18, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Pesan',
                        style: AppTextStyles.labelMd.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.outline),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Menghubungi Telepon Budi...'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.call,
                        size: 18,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Telepon',
                        style: AppTextStyles.labelMd.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  final Offset start;
  final Offset end;

  _RoutePainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(start.dx, start.dy);

    // Quad curve representation matching route line
    // Control point at (55%, 35%) of screen size
    final controlPoint = Offset(0.55 * size.width, 0.35 * size.height);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, end.dx, end.dy);

    // Draw dashed path
    final dashWidth = 8.0;
    final dashSpace = 8.0;
    double distance = 0.0;

    for (var pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
