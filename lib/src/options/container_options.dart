import 'package:flutter/material.dart';

class ContainerOptions {
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

  final double? width;
  final double? height;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Clip clipBehavior;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final BoxConstraints? constraints;
}
