import 'color_token.dart';

/// A shadow token describing a box shadow effect.
class ShadowToken {
  /// The shadow color.
  final ColorToken color;

  /// The blur radius.
  final double radius;

  /// The horizontal offset.
  final double xOffset;

  /// The vertical offset.
  final double yOffset;

  /// The shadow opacity (0.0 to 1.0).
  final double opacity;

  /// Creates a [ShadowToken].
  const ShadowToken({
    required this.color,
    required this.radius,
    required this.xOffset,
    required this.yOffset,
    this.opacity = 1.0,
  });

  /// Converts this token to a JSON-serializable map.
  Map<String, dynamic> toJson() => {
        'color': color.toJson(),
        'radius': radius,
        'xOffset': xOffset,
        'yOffset': yOffset,
        'opacity': opacity,
      };

  /// Creates a [ShadowToken] from a JSON map.
  factory ShadowToken.fromJson(Map<String, dynamic> json) => ShadowToken(
        color: ColorToken.fromJson(json['color'] as Map<String, dynamic>),
        radius: (json['radius'] as num).toDouble(),
        xOffset: (json['xOffset'] as num).toDouble(),
        yOffset: (json['yOffset'] as num).toDouble(),
        opacity: (json['opacity'] as num?)?.toDouble() ?? 1.0,
      );

  @override
  String toString() =>
      'ShadowToken(radius: $radius, offset: ($xOffset, $yOffset), opacity: $opacity)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShadowToken &&
          color == other.color &&
          radius == other.radius &&
          xOffset == other.xOffset &&
          yOffset == other.yOffset &&
          opacity == other.opacity;

  @override
  int get hashCode => Object.hash(color, radius, xOffset, yOffset, opacity);
}
