# philiprehberger_design_tokens

[![Tests](https://github.com/philiprehberger/dart-design-tokens/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/dart-design-tokens/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/philiprehberger_design_tokens.svg)](https://pub.dev/packages/philiprehberger_design_tokens)
[![Last updated](https://img.shields.io/github/last-commit/philiprehberger/dart-design-tokens)](https://github.com/philiprehberger/dart-design-tokens/commits/main)

Token-based design system with themes, JSON import/export, and validation. Zero dependencies. Pure Dart.

## Requirements

- Dart >= 3.5

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  philiprehberger_design_tokens: ^0.2.0
```

Then run:

```bash
dart pub get
```

## Usage

```dart
import 'package:philiprehberger_design_tokens/design_tokens.dart';

final theme = Theme(
  name: 'light',
  colors: {
    'primary': ColorToken.fromHex('#3366FF'),
    'background': ColorToken.fromHex('#FFFFFF'),
  },
  spacings: {
    'sm': SpacingToken(value: 8.0),
    'md': SpacingToken(value: 16.0),
  },
  typographies: {
    'body': TypographyToken(fontSize: 16.0, fontWeight: FontWeight.regular),
  },
);

final color = theme.color('primary');
print(color!.toHex()); // #3366ff
```

### Theme Switching

```dart
final manager = ThemeManager();
manager.register(lightTheme);
manager.register(darkTheme);

manager.onChange((theme) => print('Now using: ${theme.name}'));
manager.switchTo('dark');
```

### Token Types

```dart
// Colors with hex parsing
final color = ColorToken.fromHex('#FF6633');
final rgba = ColorToken(red: 1.0, green: 0.4, blue: 0.2);

// Spacing
const spacing = SpacingToken(value: 16.0);

// Typography with font weight enum
const heading = TypographyToken(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  lineHeight: 1.2,
  letterSpacing: -0.5,
);

// Shadows
final shadow = ShadowToken(
  color: ColorToken.fromHex('#000000'),
  radius: 8.0,
  xOffset: 0.0,
  yOffset: 4.0,
  opacity: 0.15,
);

// Borders
final border = BorderToken(
  width: 1.0,
  color: ColorToken.fromHex('#E0E0E0'),
  style: BorderStyle.dashed,
);
```

### Theme Merging and Extending

```dart
// Merge: other theme's tokens override matching keys
final merged = baseTheme.merging(overrideTheme);

// Extend: add tokens while keeping the original name
final extended = baseTheme.extending(
  colors: {'accent': ColorToken.fromHex('#FF6633')},
);
```

### Token Aliases

```dart
// Register semantic aliases for existing token keys
final themed = theme.withAliases({
  'brand': 'primary',
  'small': 'sm',
  'paragraph': 'body',
});

// Resolve by alias or direct name
final color = themed.resolveColor('brand');    // same as theme.color('primary')
final spacing = themed.resolveSpacing('small'); // same as theme.spacing('sm')
final typo = themed.resolveTypography('paragraph');
```

### Responsive Tokens

```dart
// Define breakpoint-dependent values
final spacing = ResponsiveToken<double>({
  'mobile': 8.0,
  'tablet': 16.0,
  'desktop': 24.0,
});

print(spacing.resolve('tablet'));          // 16.0
print(spacing.containsBreakpoint('mobile')); // true
print(spacing.breakpointNames);            // [mobile, tablet, desktop]

// JSON round-trip
final json = spacing.toJson((v) => v);
final restored = ResponsiveToken.fromJson<double>(json, (v) => (v as num).toDouble());
```

### JSON Export and Import

```dart
final exporter = TokenExporter();

// Export to JSON map
final json = exporter.exportJson(theme);

// Import from JSON map
final restored = exporter.importJson(json);

// Serialize to bytes
final bytes = exporter.serialize(theme);
final fromBytes = exporter.deserialize(bytes);
```

### Validation

```dart
final validator = TokenValidator();
final issues = validator.validate(
  theme,
  requiredColors: ['primary', 'background', 'error'],
  requiredSpacing: ['sm', 'md', 'lg'],
  requiredTypography: ['body', 'heading'],
);

for (final issue in issues) {
  print('${issue.severity.name}: ${issue.message}');
}
```

## API

### Token Types

| Class | Description |
|-------|-------------|
| `ColorToken` | RGBA color with hex parsing (`fromHex`, `toHex`) |
| `SpacingToken` | Numeric spacing value |
| `TypographyToken` | Font size, weight, line height, letter spacing |
| `ShadowToken` | Shadow with color, radius, offsets, opacity |
| `BorderToken` | Border with width, color, and style |
| `TokenAlias` | Maps an alias name to an existing token key |
| `ResponsiveToken<T>` | Breakpoint-dependent token values |

### Theme

| Method | Description |
|--------|-------------|
| `color(key)` | Look up a color token |
| `spacing(key)` | Look up a spacing token |
| `typography(key)` | Look up a typography token |
| `shadow(key)` | Look up a shadow token |
| `border(key)` | Look up a border token |
| `merging(other)` | Merge another theme (other overrides) |
| `extending(...)` | Extend with additional tokens |
| `withAliases(aliases)` | Return new theme with semantic aliases |
| `resolveColor(nameOrAlias)` | Look up color by name or alias |
| `resolveSpacing(nameOrAlias)` | Look up spacing by name or alias |
| `resolveTypography(nameOrAlias)` | Look up typography by name or alias |
| `aliases` | Registered aliases (unmodifiable map) |

### ResponsiveToken

| Method | Description |
|--------|-------------|
| `resolve(breakpoint)` | Get value for a breakpoint |
| `breakpointNames` | List of all breakpoint keys |
| `containsBreakpoint(breakpoint)` | Check if breakpoint exists |
| `toJson(serializer)` | Serialize to JSON map |
| `fromJson(json, deserializer)` | Deserialize from JSON map |

### ThemeManager

| Method | Description |
|--------|-------------|
| `register(theme)` | Register a theme |
| `switchTo(name)` | Switch active theme |
| `activeTheme` | Current active theme |
| `availableThemes` | List of registered theme names |
| `onChange(callback)` | Listen for theme changes |

### TokenExporter

| Method | Description |
|--------|-------------|
| `exportJson(theme)` | Export theme to JSON map |
| `importJson(json)` | Import theme from JSON map |
| `serialize(theme)` | Export to UTF-8 bytes |
| `deserialize(bytes)` | Import from UTF-8 bytes |

### TokenValidator

| Method | Description |
|--------|-------------|
| `validate(theme, ...)` | Validate against required token names |

## Development

```bash
dart pub get
dart analyze --fatal-infos
dart test
```

## Support

If you find this project useful:

- [Star the repo](https://github.com/philiprehberger/dart-design-tokens)
- [Report issues](https://github.com/philiprehberger/dart-design-tokens/issues?q=is%3Aissue+is%3Aopen+label%3Abug)
- [Suggest features](https://github.com/philiprehberger/dart-design-tokens/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)
- [Sponsor development](https://github.com/sponsors/philiprehberger)
- [All Open Source Projects](https://philiprehberger.com/open-source-packages)
- [GitHub Profile](https://github.com/philiprehberger)
- [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)
