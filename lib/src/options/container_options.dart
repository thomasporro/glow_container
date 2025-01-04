import 'package:flutter/material.dart';

/// Options for customizing the appearance and behavior of a rectangular
/// container used in the [GlowContainer].
class ContainerOptions {
  /// Creates options for customizing the appearance and behavior of a
  /// rectangular container used in the [GlowContainer].
  const ContainerOptions({
    this.width,
    this.height,
    this.borderRadius = 0.0,
    this.borderWidth = 1.0,
    this.borderColor = const Color(0xFF000000),
    this.padding,
    this.margin,
    this.clipBehavior = Clip.none,
    this.alignment,
    this.backgroundColor,
    this.constraints,
  });

  /// The width of the container.
  ///
  /// If null, the container default behavior will be used
  final double? width;

  /// The height of the container.
  ///
  /// If null, the container default behavior will be used
  final double? height;

  /// The border radius of the container.
  ///
  /// This value will be used in `BorderRadius.circular(borderRadius)`, by
  /// default the value will be 0.0
  final double borderRadius;

  /// The border width of the container.
  ///
  /// The default value is 1.0
  final double borderWidth;

  /// The border color of the container.
  ///
  /// The default value is [Color(0xFF000000)]
  final Color borderColor;

  /// The padding of the container.
  ///
  /// If null, the container default behavior will be used
  final EdgeInsetsGeometry? padding;

  /// The margin of the container.
  ///
  /// If null, the container default behavior will be used
  final EdgeInsetsGeometry? margin;

  /// The clip behavior of the container.
  ///
  /// The default value is [Clip.none]
  final Clip clipBehavior;

  /// The alignment of the container.
  ///
  /// If null, the container default behavior will be used
  final AlignmentGeometry? alignment;

  /// The background color of the container.
  ///
  /// If null, the container default behavior will be used
  final Color? backgroundColor;

  /// The constraints of the container.
  ///
  /// If null, the container default behavior will be used
  final BoxConstraints? constraints;
}
