/// A color token representing an RGBA color value.
class ColorToken {
  /// Red channel (0.0 to 1.0).
  final double red;

  /// Green channel (0.0 to 1.0).
  final double green;

  /// Blue channel (0.0 to 1.0).
  final double blue;

  /// Alpha channel (0.0 to 1.0).
  final double alpha;

  /// Creates a [ColorToken] with RGBA values between 0.0 and 1.0.
  ColorToken({
    required this.red,
    required this.green,
    required this.blue,
    this.alpha = 1.0,
  }) {
    if (red < 0.0 || red > 1.0) {
      throw RangeError.range(red, 0, 1, 'red');
    }
    if (green < 0.0 || green > 1.0) {
      throw RangeError.range(green, 0, 1, 'green');
    }
    if (blue < 0.0 || blue > 1.0) {
      throw RangeError.range(blue, 0, 1, 'blue');
    }
    if (alpha < 0.0 || alpha > 1.0) {
      throw RangeError.range(alpha, 0, 1, 'alpha');
    }
  }

  /// Creates a [ColorToken] from a hex string.
  ///
  /// Accepts formats: `#RGB`, `#RRGGBB`, `#RRGGBBAA`, `RGB`, `RRGGBB`, `RRGGBBAA`.
  factory ColorToken.fromHex(String hex) {
    var h = hex.startsWith('#') ? hex.substring(1) : hex;

    if (h.length == 3) {
      h = '${h[0]}${h[0]}${h[1]}${h[1]}${h[2]}${h[2]}';
    }

    if (h.length != 6 && h.length != 8) {
      throw FormatException('Invalid hex color: $hex');
    }

    final r = int.parse(h.substring(0, 2), radix: 16);
    final g = int.parse(h.substring(2, 4), radix: 16);
    final b = int.parse(h.substring(4, 6), radix: 16);
    final a = h.length == 8 ? int.parse(h.substring(6, 8), radix: 16) : 255;

    return ColorToken(
      red: r / 255.0,
      green: g / 255.0,
      blue: b / 255.0,
      alpha: a / 255.0,
    );
  }

  /// Converts this color to a hex string in `#RRGGBB` or `#RRGGBBAA` format.
  String toHex({bool includeAlpha = false}) {
    final r = (red * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final g = (green * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
    final b = (blue * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');

    if (includeAlpha) {
      final a = (alpha * 255).round().clamp(0, 255).toRadixString(16).padLeft(2, '0');
      return '#$r$g$b$a';
    }

    return '#$r$g$b';
  }

  /// Converts this token to a JSON-serializable map.
  Map<String, dynamic> toJson() => {
        'red': red,
        'green': green,
        'blue': blue,
        'alpha': alpha,
      };

  /// Creates a [ColorToken] from a JSON map.
  factory ColorToken.fromJson(Map<String, dynamic> json) => ColorToken(
        red: (json['red'] as num).toDouble(),
        green: (json['green'] as num).toDouble(),
        blue: (json['blue'] as num).toDouble(),
        alpha: (json['alpha'] as num?)?.toDouble() ?? 1.0,
      );

  @override
  String toString() => 'ColorToken(${toHex()}, alpha: $alpha)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorToken &&
          red == other.red &&
          green == other.green &&
          blue == other.blue &&
          alpha == other.alpha;

  @override
  int get hashCode => Object.hash(red, green, blue, alpha);
}
