import 'dart:math';

import 'package:flutter/widgets.dart';

class AnimatedBorderPainter extends CustomPainter {
  AnimatedBorderPainter({
    required this.angle,
    required this.gradientColors,
    this.radius = 0,
    this.thickness = 1,
    this.glowRadius = 2.0,
  });

  final double radius;
  final double thickness;
  final double angle;
  final double glowRadius;
  final List<Color> gradientColors;

  @override
  void paint(final Canvas canvas, final Size size) {
    final Rect borderRect = Rect.fromLTWH(
      0 + thickness / 2,
      0 + thickness / 2,
      size.width - thickness,
      size.height - thickness,
    );

    final RRect rrect = RRect.fromRectAndRadius(
      borderRect,
      Radius.circular(
        max(radius - thickness / 2, 0),
      ),
    );

    final RRect glowRrect = rrect.inflate(thickness / 2);

    final Shader shader = SweepGradient(
      colors: gradientColors,
      transform: GradientRotation(angle),
    ).createShader(borderRect);

    final Paint paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    canvas.drawRRect(rrect, paint);

    if (glowRadius == 0) {
      return;
    }

    final Paint glowPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.fill
      ..strokeWidth = glowRadius
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, glowRadius);

    canvas.drawRRect(glowRrect, glowPaint);
  }

  @override
  bool shouldRepaint(covariant final AnimatedBorderPainter oldDelegate) =>
      oldDelegate.radius != radius ||
      oldDelegate.thickness != thickness ||
      oldDelegate.angle != angle ||
      oldDelegate.glowRadius != glowRadius ||
      oldDelegate.gradientColors != gradientColors;
}
