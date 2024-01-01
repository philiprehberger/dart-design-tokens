/// Font weight values for typography tokens.
enum FontWeight {
  /// Weight 100.
  ultraLight,

  /// Weight 200.
  thin,

  /// Weight 300.
  light,

  /// Weight 400.
  regular,

  /// Weight 500.
  medium,

  /// Weight 600.
  semibold,

  /// Weight 700.
  bold,

  /// Weight 800.
  heavy,

  /// Weight 900.
  black,
}

/// A typography token describing text styling.
class TypographyToken {
  /// The font size in logical pixels.
  final double fontSize;

  /// The font weight.
  final FontWeight fontWeight;

  /// The line height multiplier (optional).
  final double? lineHeight;

  /// The letter spacing in logical pixels (optional).
  final double? letterSpacing;

  /// Creates a [TypographyToken].
  const TypographyToken({
    required this.fontSize,
    required this.fontWeight,
    this.lineHeight,
    this.letterSpacing,
  });

  /// Converts this token to a JSON-serializable map.
  Map<String, dynamic> toJson() => {
        'fontSize': fontSize,
        'fontWeight': fontWeight.name,
        if (lineHeight != null) 'lineHeight': lineHeight,
        if (letterSpacing != null) 'letterSpacing': letterSpacing,
      };

  /// Creates a [TypographyToken] from a JSON map.
  factory TypographyToken.fromJson(Map<String, dynamic> json) =>
      TypographyToken(
        fontSize: (json['fontSize'] as num).toDouble(),
        fontWeight: FontWeight.values.byName(json['fontWeight'] as String),
        lineHeight: (json['lineHeight'] as num?)?.toDouble(),
        letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
      );

  @override
  String toString() =>
      'TypographyToken(fontSize: $fontSize, fontWeight: ${fontWeight.name})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypographyToken &&
          fontSize == other.fontSize &&
          fontWeight == other.fontWeight &&
          lineHeight == other.lineHeight &&
          letterSpacing == other.letterSpacing;

  @override
  int get hashCode => Object.hash(fontSize, fontWeight, lineHeight, letterSpacing);
}
