import 'color_token.dart';
import 'spacing_token.dart';
import 'typography_token.dart';
import 'shadow_token.dart';
import 'border_token.dart';

/// A design theme containing named collections of design tokens.
class Theme {
  /// The theme name.
  final String name;

  /// Color tokens keyed by name.
  final Map<String, ColorToken> colors;

  /// Spacing tokens keyed by name.
  final Map<String, SpacingToken> spacings;

  /// Typography tokens keyed by name.
  final Map<String, TypographyToken> typographies;

  /// Shadow tokens keyed by name.
  final Map<String, ShadowToken> shadows;

  /// Border tokens keyed by name.
  final Map<String, BorderToken> borders;

  /// Creates a [Theme] with the given token maps.
  const Theme({
    required this.name,
    this.colors = const {},
    this.spacings = const {},
    this.typographies = const {},
    this.shadows = const {},
    this.borders = const {},
  });

  /// Looks up a color token by [key]. Returns `null` if not found.
  ColorToken? color(String key) => colors[key];

  /// Looks up a spacing token by [key]. Returns `null` if not found.
  SpacingToken? spacing(String key) => spacings[key];

  /// Looks up a typography token by [key]. Returns `null` if not found.
  TypographyToken? typography(String key) => typographies[key];

  /// Looks up a shadow token by [key]. Returns `null` if not found.
  ShadowToken? shadow(String key) => shadows[key];

  /// Looks up a border token by [key]. Returns `null` if not found.
  BorderToken? border(String key) => borders[key];

  /// Creates a new theme by merging [other] into this theme.
  ///
  /// Tokens from [other] override tokens in this theme when keys collide.
  Theme merging(Theme other) => Theme(
        name: other.name,
        colors: {...colors, ...other.colors},
        spacings: {...spacings, ...other.spacings},
        typographies: {...typographies, ...other.typographies},
        shadows: {...shadows, ...other.shadows},
        borders: {...borders, ...other.borders},
      );

  /// Creates a new theme by extending this theme with additional tokens.
  ///
  /// Unlike [merging], the resulting theme keeps this theme's name.
  Theme extending({
    Map<String, ColorToken>? colors,
    Map<String, SpacingToken>? spacings,
    Map<String, TypographyToken>? typographies,
    Map<String, ShadowToken>? shadows,
    Map<String, BorderToken>? borders,
  }) =>
      Theme(
        name: name,
        colors: {...this.colors, ...?colors},
        spacings: {...this.spacings, ...?spacings},
        typographies: {...this.typographies, ...?typographies},
        shadows: {...this.shadows, ...?shadows},
        borders: {...this.borders, ...?borders},
      );

  /// Converts this theme to a JSON-serializable map.
  Map<String, dynamic> toJson() => {
        'name': name,
        'colors': colors.map((k, v) => MapEntry(k, v.toJson())),
        'spacings': spacings.map((k, v) => MapEntry(k, v.toJson())),
        'typographies': typographies.map((k, v) => MapEntry(k, v.toJson())),
        'shadows': shadows.map((k, v) => MapEntry(k, v.toJson())),
        'borders': borders.map((k, v) => MapEntry(k, v.toJson())),
      };

  /// Creates a [Theme] from a JSON map.
  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        name: json['name'] as String,
        colors: (json['colors'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, ColorToken.fromJson(v as Map<String, dynamic>)),
            ) ??
            {},
        spacings: (json['spacings'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, SpacingToken.fromJson(v as Map<String, dynamic>)),
            ) ??
            {},
        typographies: (json['typographies'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, TypographyToken.fromJson(v as Map<String, dynamic>)),
            ) ??
            {},
        shadows: (json['shadows'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, ShadowToken.fromJson(v as Map<String, dynamic>)),
            ) ??
            {},
        borders: (json['borders'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, BorderToken.fromJson(v as Map<String, dynamic>)),
            ) ??
            {},
      );

  @override
  String toString() => 'Theme($name)';
}
