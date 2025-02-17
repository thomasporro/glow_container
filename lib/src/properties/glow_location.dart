/// {@template gl_glow_location}
/// Enum that defines where the glow is located on the container.
///
/// * `both` - The glow is located on both the border and the outer part of the container.
/// * `borderOnly` - The glow is located only on the border of the container.
/// * `outerOnly` - The glow is located only on the outer part of the container.
/// {@endtemplate}
enum GlowLocation {
  /// The glow is located on both the border and the outer part of the container.
  both,

  /// The glow is located only on the border of the container.
  borderOnly,

  /// The glow is located only on the outer part of the container.
  outerOnly;

  /// Whether the border should be painted.
  bool get shouldPaintBorder => this != GlowLocation.outerOnly;

  /// Whether the glow should be painted.
  bool get shouldPaintGlow => this != GlowLocation.borderOnly;
}
