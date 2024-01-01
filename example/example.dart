// ignore_for_file: unused_local_variable

import 'package:philiprehberger_design_tokens/design_tokens.dart';

void main() {
  // Define color tokens
  final primary = ColorToken.fromHex('#3366FF');
  final background = ColorToken.fromHex('#FFFFFF');
  final surface = ColorToken.fromHex('#F5F5F5');

  // Define spacing tokens
  const spacingSm = SpacingToken(value: 8.0);
  const spacingMd = SpacingToken(value: 16.0);
  const spacingLg = SpacingToken(value: 32.0);

  // Define typography tokens
  const heading = TypographyToken(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    lineHeight: 1.2,
  );
  const body = TypographyToken(
    fontSize: 16.0,
    fontWeight: FontWeight.regular,
    lineHeight: 1.5,
    letterSpacing: 0.15,
  );

  // Build a light theme
  final lightTheme = Theme(
    name: 'light',
    colors: {
      'primary': primary,
      'background': background,
      'surface': surface,
    },
    spacings: {'sm': spacingSm, 'md': spacingMd, 'lg': spacingLg},
    typographies: {'heading': heading, 'body': body},
    shadows: {
      'card': ShadowToken(
        color: ColorToken.fromHex('#000000'),
        radius: 8.0,
        xOffset: 0.0,
        yOffset: 4.0,
        opacity: 0.1,
      ),
    },
    borders: {
      'default': BorderToken(
        width: 1.0,
        color: ColorToken.fromHex('#E0E0E0'),
      ),
    },
  );

  // Build a dark theme by extending
  final darkTheme = Theme(
    name: 'dark',
    colors: {
      'primary': ColorToken.fromHex('#6699FF'),
      'background': ColorToken.fromHex('#121212'),
      'surface': ColorToken.fromHex('#1E1E1E'),
    },
    spacings: {'sm': spacingSm, 'md': spacingMd, 'lg': spacingLg},
    typographies: {'heading': heading, 'body': body},
  );

  // Use ThemeManager to switch themes
  final manager = ThemeManager();
  manager.register(lightTheme);
  manager.register(darkTheme);

  manager.onChange((theme) {
    print('Switched to: ${theme.name}');
  });

  manager.switchTo('light');
  print('Primary color: ${manager.activeTheme!.color("primary")!.toHex()}');
  print('Body font size: ${manager.activeTheme!.typography("body")!.fontSize}');

  manager.switchTo('dark');
  print('Primary color: ${manager.activeTheme!.color("primary")!.toHex()}');

  // Export and import
  final exporter = TokenExporter();
  final json = exporter.exportJson(lightTheme);
  print('Exported theme: ${json["name"]}');

  final restored = exporter.importJson(json);
  print('Imported theme: ${restored.name}');

  // Validate a theme
  final validator = TokenValidator();
  final issues = validator.validate(
    lightTheme,
    requiredColors: ['primary', 'background', 'error'],
    requiredSpacing: ['sm', 'md'],
    requiredTypography: ['body'],
  );

  for (final issue in issues) {
    print('${issue.severity.name}: ${issue.message}');
  }
}
