import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glow_container/glow_container.dart';

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
    this.margin,
    this.radius = 0,
    @Deprecated(
      'Please use borderSide.width instead',
    )
    this.thickness = 1,
    this.glowRadius = 2.0,
    this.textDirection = TextDirection.ltr,
    this.borderSide,
    this.glowLocation = GlowLocation.both,
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
        ),
        assert(
          margin == null ||
              margin is EdgeInsets ||
              margin is EdgeInsetsDirectional ||
              margin.isNonNegative,
          'margin must be null or of type EdgeInsets or EdgeInsetsDirectional. '
          'If margin is not null, it must be non-negative.',
        ),
        _hiddenBorderSide = borderSide ?? BorderSide(width: thickness);

  /// The radius of the border.
  ///
  /// Defaults to 0.
  final double radius;

  /// The thickness of the border.
  ///
  /// Defaults to 1.
  ///
  /// If [borderSide] is provided it will overwrite [thickness] property because
  /// of its deprecation.
  @Deprecated(
    'Please use borderSide.width instead',
  )
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

  /// The margin of the container.
  ///
  /// This variable MUST be of type [EdgeInsets] or
  /// [EdgeInsetsDirectional] in order to be used. In this way is possibile to
  /// add correctly the margin of a container.
  ///
  /// This will modify where the gradient is drawn
  final EdgeInsetsGeometry? margin;

  /// The text direction used in the app.
  ///
  /// Is used to resolve the correct direction of the margin in the glowing
  /// effect.
  final TextDirection textDirection;

  /// The border side used to correct render the border.
  final BorderSide? borderSide;

  /// The correct computed border side.
  final BorderSide _hiddenBorderSide;

  /// The glow location.
  ///
  /// It allows the user to decide where the effect is located.
  final GlowLocation glowLocation;

  @override
  void paint(final Canvas canvas, final Size size) {
    late ({
      double left,
      double top,
      double right,
      double bottom,
    }) marginRecord;

    switch (margin?.runtimeType) {
      case == EdgeInsets:
        final EdgeInsets localMargin = margin! as EdgeInsets;
        marginRecord = (
          left: localMargin.left,
          top: localMargin.top,
          right: localMargin.right,
          bottom: localMargin.bottom
        );
      case == EdgeInsetsDirectional when textDirection == TextDirection.ltr:
        final EdgeInsetsDirectional localMargin = margin! as EdgeInsetsDirectional;
        marginRecord = (
          left: localMargin.start,
          top: localMargin.top,
          right: localMargin.end,
          bottom: localMargin.bottom,
        );
      case == EdgeInsetsDirectional when textDirection == TextDirection.rtl:
        final EdgeInsetsDirectional localMargin = margin! as EdgeInsetsDirectional;
        marginRecord = (
          left: localMargin.end,
          top: localMargin.top,
          right: localMargin.start,
          bottom: localMargin.bottom,
        );
      default:
        marginRecord = (
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
        );
    }

    final Rect rect = Rect.fromLTWH(
      marginRecord.left,
      marginRecord.top,
      size.width - marginRecord.left - marginRecord.right,
      size.height - marginRecord.top - marginRecord.bottom,
    );

    final RRect borderRect = BorderRadius.circular(radius).toRRect(rect);

    final Shader shader = SweepGradient(
      colors: gradientColors,
      transform: GradientRotation(angle),
    ).createShader(rect);

    final Paint gradientPaint = Paint()..shader = shader;

    // Draw the border effect if it's not outer only
    if (glowLocation.shouldPaintBorder) {
      if (_hiddenBorderSide.width == 0.0) {
        gradientPaint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.0;
        canvas.drawRRect(borderRect, gradientPaint);
      } else {
        gradientPaint
          ..style = PaintingStyle.fill
          ..color = gradientColors[0];
        final RRect inner = borderRect.deflate(_hiddenBorderSide.strokeInset);
        final RRect outer = borderRect.inflate(_hiddenBorderSide.strokeOutset);
        canvas.drawDRRect(outer, inner, gradientPaint);
      }
    }

    // final RRect inner = testRect.deflate(strokeInset);
    // final RRect outer = testRect.inflate(strokeOutset);
    // Early return if border only since there is no need to draw the glow
    if (!glowLocation.shouldPaintGlow) {
      return;
    }

    final RRect glowRrect = borderRect.inflate(_hiddenBorderSide.strokeOutset);

    gradientPaint
      ..style = PaintingStyle.fill
      ..strokeWidth = glowRadius
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, glowRadius);

    canvas.drawRRect(glowRrect, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant final AnimatedBorderPainter oldDelegate) =>
      oldDelegate.radius != radius ||
      oldDelegate.thickness != thickness ||
      oldDelegate.angle != angle ||
      oldDelegate.glowRadius != glowRadius ||
      oldDelegate.gradientColors != gradientColors ||
      oldDelegate.margin != margin ||
      oldDelegate.textDirection != textDirection ||
      oldDelegate.borderSide != borderSide;
}
