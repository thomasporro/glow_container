import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:glow_container/src/animated_border_painter.dart';
import 'package:glow_container/src/options/container_options.dart';

/// A highly customizable Flutter widget that enhances a rectangular container
/// with an animated glowing border effect.
///
/// The [GlowContainer] combines custom painting and animation techniques to
/// create a dynamic, glowing border around a rectangular container. The glow
/// effect is achieved through a rotating gradient that follows the rectangular
/// container's borders, which can be customized in terms of colors, radius, and
/// animation timing.
///
/// Features:
/// * Rectangular container with animated gradient border and customizable
/// rotation speed
/// * Adjustable glow radius for controlling the spread of the effect around the
///  rectangle
/// * Multiple gradient colors support for rich visual effects along the
/// rectangular border
/// * Smooth transitions with configurable duration
/// * Optional border animation that can be toggled on/off
/// * Extensive container styling through [ContainerOptions] for the rectangular
/// shape
///
/// The border animation creates a continuous rotation effect along the
/// rectangular path using the provided [gradientColors], while the glow effect
/// is controlled by [glowRadius]. The widget ensures smooth state transitions
/// and proper resource cleanup.
class GlowContainer extends StatefulWidget {
  /// Create a widget that combines animation, painter in order to create a glow
  /// effect around a container.
  GlowContainer({
    required this.gradientColors,
    required this.child,
    this.glowRadius = 4.0,
    this.showAnimatedBorder = true,
    this.rotationDuration = const Duration(seconds: 2),
    this.transitionDuration = const Duration(milliseconds: 300),
    this.containerOptions = const ContainerOptions(),
    super.key,
  })  : assert(
          gradientColors.isNotEmpty,
          'gradientColors must have at least 1 color',
        ),
        assert(
          glowRadius >= 0,
          'glowRadius must be a positive number',
        ),
        assert(
          rotationDuration > Duration.zero,
          'rotationDuration must be greater than 0',
        ),
        assert(
          transitionDuration > Duration.zero,
          'transitionDuration must be greater than 0',
        );

  /// The list of colors used to create the glowing effect
  ///
  /// This list is used to create the [glowColors] variable that is used in the
  /// [AnimatedBorderPainter] to control the glow effect.
  ///
  /// If the [gradientColors] list has only one color, the [glowColors] will be
  /// created by duplicating the single color. Otherwise, the [glowColors] will
  /// be populated with the same colors as the [gradientColors] list, with the
  /// last color duplicated to create a continuous glow effect.
  final List<Color> gradientColors;

  /// Whether the animated border should be shown
  ///
  /// This variable is used to control whether to render the animated border or
  /// the the static color passed inside the [containerOptions.borderColor].
  final bool showAnimatedBorder;

  /// The glow radius
  ///
  /// This will effect the size of the glow. By design the glow will be rendered
  /// outside of the widget borders.
  ///
  /// This value must be greater than or equal to 0. If [glowRadius] is 0, the
  /// glow will not be rendered.
  final double glowRadius;

  /// The duration one one rotation animation of the [gradientColors] along the
  /// container borders
  final Duration rotationDuration;

  /// The duration for the transition animation between the animated border and
  /// the static color.
  final Duration transitionDuration;

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.ProxyWidgets.child}
  final Widget? child;

  /// The options for the container
  final ContainerOptions containerOptions;

  @override
  State<GlowContainer> createState() => _GlowContainerState();
}

class _GlowContainerState extends State<GlowContainer>
    with TickerProviderStateMixin {
  // The maximum alpha value
  static const int _maxAlpha = 255;

  // The glow colors actually used in the Painter
  late List<Color> _glowColors;

  // The rotation controller
  late AnimationController _rotationController;
  late Animation<double> _angleAnimation;

  // The transition controller
  late AnimationController _transitionController;
  late Animation<double> _transitionAnimation;

  @override
  void initState() {
    super.initState();

    _glowColors = List<Color>.from(
      <Color>[...widget.gradientColors, widget.gradientColors.first],
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: widget.rotationDuration,
    );

    _angleAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_rotationController);

    _transitionController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    );

    _transitionAnimation = Tween<double>(
      begin: 0,
      end: _maxAlpha.toDouble(),
    ).animate(_transitionController);

    if (widget.showAnimatedBorder && widget.gradientColors.length > 1) {
      _rotationController.repeat();
    }

    // If the widget's showAnimatedBorder is false, the transition animation
    // should be set to the maximum alpha value since the colors are not visible
    if (!widget.showAnimatedBorder) {
      _transitionController.value = _maxAlpha.toDouble();
    }
  }

  @override
  void didUpdateWidget(covariant final GlowContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The rotation animation should start when this conditions are met:
    // 1. The controller is not animating
    // 2. The Widget's colors list has more than 1 color
    // 3. The Widget's showAnimatedBorder is true
    //
    // If the rotationController duration as changed the controller should call
    // `repeat()` even if the controller is already animating.
    final bool shouldBeRotating =
        widget.showAnimatedBorder && widget.gradientColors.length > 1;

    // The transition animation should start when this conditions are met:
    // 1. The Widget's showAnimatedBorder has changed its value to `true` or
    // `false`
    //
    // The direction of the transition it's controlled by the Widget's
    // showAnimatedBorder value
    final bool shouldStartTransitionAnimation =
        oldWidget.showAnimatedBorder != widget.showAnimatedBorder;

    if (oldWidget.gradientColors != widget.gradientColors) {
      _glowColors = List<Color>.from(
        <Color>[...widget.gradientColors, widget.gradientColors.first],
      );
    }

    if (oldWidget.rotationDuration != widget.rotationDuration) {
      _rotationController.duration = widget.rotationDuration;
    }

    if (oldWidget.transitionDuration != widget.transitionDuration) {
      _transitionController.duration = widget.transitionDuration;
    }

    // Updating the rotation animation
    if (!shouldBeRotating && _rotationController.isAnimating) {
      if (!shouldStartTransitionAnimation) {
        _rotationController.stop();
      }
    }
    if (shouldBeRotating &&
        (!_rotationController.isAnimating ||
            oldWidget.rotationDuration != widget.rotationDuration)) {
      _rotationController.repeat();
    }

    // Updating the transition animation
    if (shouldStartTransitionAnimation) {
      if (widget.showAnimatedBorder) {
        _transitionController.reverse();
      } else {
        _transitionController.forward().whenComplete(
          () {
            _rotationController.stop();
          },
        );
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
        animation: _transitionAnimation,
        builder: (final BuildContext context, final Widget? child) =>
            AnimatedBuilder(
          animation: _rotationController,
          builder: (final BuildContext context, final Widget? child) =>
              CustomPaint(
            painter: AnimatedBorderPainter(
              angle: _angleAnimation.value,
              radius: widget.containerOptions.borderRadius,
              margin: widget.containerOptions.margin,
              textDirection:
                  Directionality.maybeOf(context) ?? TextDirection.ltr,
              glowRadius: widget.glowRadius,
              gradientColors: _glowColors
                  .map(
                    (final Color c) => c.withAlpha(
                      _maxAlpha - _transitionAnimation.value.toInt(),
                    ),
                  )
                  .toList(),
              thickness: widget.containerOptions.borderWidth,
            ),
            child: Container(
              margin: widget.containerOptions.margin,
              padding: widget.containerOptions.padding,
              width: widget.containerOptions.width,
              height: widget.containerOptions.height,
              alignment: widget.containerOptions.alignment,
              clipBehavior: widget.containerOptions.clipBehavior,
              constraints: widget.containerOptions.constraints,
              decoration: BoxDecoration(
                border: Border.all(
                  width: widget.containerOptions.borderWidth,
                  color: widget.containerOptions.borderColor.withAlpha(
                    _transitionAnimation.value.toInt(),
                  ),
                ),
                borderRadius: BorderRadius.circular(
                  widget.containerOptions.borderRadius,
                ),
                color: widget.containerOptions.backgroundColor,
              ),
              child: widget.child,
            ),
          ),
        ),
      );
}
