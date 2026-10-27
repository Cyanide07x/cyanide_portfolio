import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class ProjectPolygonPainter extends CustomPainter {
  const ProjectPolygonPainter();

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final Paint paint = Paint()
      ..color = AppColors.primary.withValues(
        alpha: 0.9,
      );

    final Path path = Path();

    path.moveTo(
      size.width * 0.55,
      0,
    );

    path.lineTo(
      size.width * 0.98,
      size.height * 0.20,
    );

    path.lineTo(
      size.width * 0.88,
      size.height * 0.80,
    );

    path.lineTo(
      size.width * 0.38,
      size.height,
    );

    path.lineTo(
      0,
      size.height * 0.55,
    );

    path.close();

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}
