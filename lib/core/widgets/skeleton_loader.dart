import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';

class BackendLoadingSimulator extends StatefulWidget {
  const BackendLoadingSimulator({
    required this.child,
    required this.skeleton,
    this.delay = const Duration(milliseconds: 1100),
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final Widget skeleton;
  final Duration delay;
  final bool enabled;

  @override
  State<BackendLoadingSimulator> createState() =>
      _BackendLoadingSimulatorState();
}

class _BackendLoadingSimulatorState extends State<BackendLoadingSimulator> {
  Timer? _timer;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _startLoadingCycle();
  }

  @override
  void didUpdateWidget(covariant BackendLoadingSimulator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled ||
        oldWidget.delay != widget.delay) {
      _startLoadingCycle();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLoadingCycle() {
    _timer?.cancel();
    _isLoading = widget.enabled && widget.delay > Duration.zero;
    if (!_isLoading) return;

    _timer = Timer(widget.delay, () {
      if (!mounted) return;
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) return widget.child;

    return Semantics(
      label: 'Memuat data',
      child: ExcludeSemantics(child: SkeletonLoading(child: widget.skeleton)),
    );
  }
}

class SkeletonLoading extends StatefulWidget {
  const SkeletonLoading({required this.child, super.key});

  final Widget child;

  @override
  State<SkeletonLoading> createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final position = (_controller.value * 2.8) - 1.4;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(position - 1, 0),
              end: Alignment(position + 1, 0),
              colors: const [
                AppColors.surfaceContainer,
                AppColors.surfaceContainerLowest,
                AppColors.surfaceContainer,
              ],
              stops: const [0.22, 0.5, 0.78],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    this.width,
    this.height,
    this.borderRadius = 12,
    this.margin = EdgeInsets.zero,
    super.key,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
