import 'color_token.dart';

/// Border style options.
enum BorderStyle {
  /// A solid line.
  solid,

  /// A dashed line.
  dashed,

  /// A dotted line.
  dotted,
}

/// A border token describing a border's appearance.
class BorderToken {
  /// The border width in logical pixels.
  final double width;

  /// The border color.
  final ColorToken color;

  /// The border style.
  final BorderStyle style;

  /// Creates a [BorderToken].
  const BorderToken({
    required this.width,
    required this.color,
    this.style = BorderStyle.solid,
  });

  /// Converts this token to a JSON-serializable map.
  Map<String, dynamic> toJson() => {
        'width': width,
        'color': color.toJson(),
        'style': style.name,
      };

  /// Creates a [BorderToken] from a JSON map.
  factory BorderToken.fromJson(Map<String, dynamic> json) => BorderToken(
        width: (json['width'] as num).toDouble(),
        color: ColorToken.fromJson(json['color'] as Map<String, dynamic>),
        style: BorderStyle.values.byName(json['style'] as String),
      );

  @override
  String toString() =>
      'BorderToken(width: $width, style: ${style.name})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorderToken &&
          width == other.width &&
          color == other.color &&
          style == other.style;

  @override
  int get hashCode => Object.hash(width, color, style);
}
