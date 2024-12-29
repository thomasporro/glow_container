import 'dart:math';

import 'package:flutter/widgets.dart';

/// A custom painter used to draw a rotating gradient border around a
/// rectangular container.
class AnimatedBorderPainter extends CustomPainter {
  /// The constructor for the [AnimatedBorderPainter] class.
  ///
  /// Inside it uses the provided [angle], [radius], [thickness], [glowRadius],
  /// and [gradientColors] to draw a rotating gradient border around a
  /// rectangular container. In the specific it uses [SweepGradient] to create a
  /// gradient along the border of the container, and uses [MaskFilter.blur] to
  /// apply a blur effect to the gradient to create a glowing effect.
  AnimatedBorderPainter({
    required this.angle,
    required this.gradientColors,
    this.radius = 0,
    this.thickness = 1,
    this.glowRadius = 2.0,
  })  : assert(
          gradientColors.length > 1,
          'AnimatedBorderPainter requires at least two colors to create a gradient',
        ),
        assert(
          glowRadius >= 0,
          'AnimatedBorderPainter glowRadius must be greater than or equal to 0',
        ),
        assert(
          radius >= 0,
          'AnimatedBorderPainter radius must be greater than or equal to 0',
        ),
        assert(
          thickness >= 0,
          'AnimatedBorderPainter thickness must be greater than or equal to 0',
        );

  /// The radius of the border.
  ///
  /// Defaults to 0.
  final double radius;

  /// The thickness of the border.
  ///
  /// Defaults to 1.
  final double thickness;

  /// The angle of the gradient.
  ///
  /// Is it uses to determine the position of the colors along the border and
  /// the glowing effect.
  final double angle;

  /// The radius of the glowing effect.
  ///
  /// Defaults to 2.
  final double glowRadius;

  /// The colors of the gradient.
  ///
  /// The length of the list should be at least 2.
  ///
  /// The gradient is created using [SweepGradient] and is rotated by the
  /// provided [angle] to create a rotating gradient.
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
