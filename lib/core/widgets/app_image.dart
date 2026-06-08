import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    required this.source,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    super.key,
  });

  final String source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = source.startsWith('assets/')
        ? Image.asset(source, width: width, height: height, fit: fit)
        : Image.network(source, width: width, height: height, fit: fit);

    if (borderRadius == null) return image;

    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}
