import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReactivePolygon extends StatelessWidget {
  final Offset mousePosition;
  final Size areaSize;

  const ReactivePolygon({
    super.key,
    required this.mousePosition,
    required this.areaSize,
  });

  @override
  Widget build(BuildContext context) {
    final double centerX = areaSize.width / 2;
    final double centerY = areaSize.height / 2;

    final double dx = mousePosition.dx - centerX;
    final double dy = mousePosition.dy - centerY;

    final double normalizedX =
        (dx / centerX).clamp(-1.0, 1.0);

    final double normalizedY =
        (dy / centerY).clamp(-1.0, 1.0);

    final double moveX = normalizedX * 18;
    final double moveY = normalizedY * 12;
    final double rotation = normalizedX * 0.025;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      transform: Matrix4.identity()
        ..translateByDouble(moveX, moveY, 0, 1)
        ..rotateZ(rotation),
      child: Opacity(
        opacity: 0.45,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 3,
            sigmaY: 3,
          ),
          child: SvgPicture.asset(
            'assets/images/logos/corner_decorations.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}