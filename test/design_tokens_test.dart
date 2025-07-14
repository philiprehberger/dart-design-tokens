import 'package:test/test.dart';
import 'package:philiprehberger_design_tokens/design_tokens.dart';

void main() {
  group('ColorToken', () {
    test('creates from RGBA values', () {
      final color = ColorToken(red: 1.0, green: 0.5, blue: 0.0);
      expect(color.red, 1.0);
      expect(color.green, 0.5);
      expect(color.blue, 0.0);
      expect(color.alpha, 1.0);
    });

    test('parses 6-digit hex', () {
      final color = ColorToken.fromHex('#FF8000');
      expect(color.red, 1.0);
      expect(color.green, closeTo(0.502, 0.01));
      expect(color.blue, 0.0);
    });

    test('parses 3-digit hex', () {
      final color = ColorToken.fromHex('#F80');
      expect(color.red, 1.0);
      expect(color.green, closeTo(0.533, 0.01));
      expect(color.blue, 0.0);
    });

    test('parses 8-digit hex with alpha', () {
      final color = ColorToken.fromHex('#FF800080');
      expect(color.alpha, closeTo(0.502, 0.01));
    });

    test('parses hex without hash prefix', () {
      final color = ColorToken.fromHex('FF0000');
      expect(color.red, 1.0);
      expect(color.green, 0.0);
      expect(color.blue, 0.0);
    });

    test('throws on invalid hex', () {
      expect(() => ColorToken.fromHex('#ZZZZZZ'), throwsFormatException);
    });

    test('throws on wrong length hex', () {
      expect(() => ColorToken.fromHex('#ABCD'), throwsFormatException);
    });

    test('converts to hex string', () {
      final color = ColorToken(red: 1.0, green: 0.0, blue: 0.0);
      expect(color.toHex(), '#ff0000');
    });

    test('converts to hex with alpha', () {
      final color = ColorToken(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5);
      expect(color.toHex(includeAlpha: true), '#ff000080');
    });

    test('round-trips through JSON', () {
      final original = ColorToken(red: 0.2, green: 0.4, blue: 0.6, alpha: 0.8);
      final restored = ColorToken.fromJson(original.toJson());
      expect(restored, equals(original));
    });
  });

  group('SpacingToken', () {
    test('creates with value', () {
      final token = SpacingToken(value: 16.0);
      expect(token.value, 16.0);
    });

    test('round-trips through JSON', () {
      final original = SpacingToken(value: 24.0);
      final restored = SpacingToken.fromJson(original.toJson());
      expect(restored, equals(original));
    });
  });

  group('TypographyToken', () {
    test('creates with required fields', () {
      final token = TypographyToken(fontSize: 16.0, fontWeight: FontWeight.regular);
      expect(token.fontSize, 16.0);
      expect(token.fontWeight, FontWeight.regular);
      expect(token.lineHeight, isNull);
      expect(token.letterSpacing, isNull);
    });

    test('creates with optional fields', () {
      final token = TypographyToken(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        lineHeight: 1.5,
        letterSpacing: 0.5,
      );
      expect(token.lineHeight, 1.5);
      expect(token.letterSpacing, 0.5);
    });

    test('round-trips through JSON', () {
      final original = TypographyToken(
        fontSize: 14.0,
        fontWeight: FontWeight.semibold,
        lineHeight: 1.4,
      );
      final restored = TypographyToken.fromJson(original.toJson());
      expect(restored, equals(original));
    });
  });

  group('ShadowToken', () {
    test('creates with all fields', () {
      final color = ColorToken(red: 0.0, green: 0.0, blue: 0.0);
      final token = ShadowToken(
        color: color,
        radius: 8.0,
        xOffset: 2.0,
        yOffset: 4.0,
        opacity: 0.25,
      );
      expect(token.radius, 8.0);
      expect(token.xOffset, 2.0);
      expect(token.yOffset, 4.0);
      expect(token.opacity, 0.25);
    });

    test('defaults opacity to 1.0', () {
      final color = ColorToken(red: 0.0, green: 0.0, blue: 0.0);
      final token = ShadowToken(color: color, radius: 4.0, xOffset: 0.0, yOffset: 2.0);
      expect(token.opacity, 1.0);
    });

    test('round-trips through JSON', () {
      final color = ColorToken(red: 0.1, green: 0.2, blue: 0.3);
      final original = ShadowToken(
        color: color,
        radius: 10.0,
        xOffset: 1.0,
        yOffset: 3.0,
        opacity: 0.5,
      );
      final restored = ShadowToken.fromJson(original.toJson());
      expect(restored, equals(original));
    });
  });

  group('BorderToken', () {
    test('creates with all fields', () {
      final color = ColorToken(red: 0.5, green: 0.5, blue: 0.5);
      final token = BorderToken(width: 2.0, color: color, style: BorderStyle.dashed);
      expect(token.width, 2.0);
      expect(token.style, BorderStyle.dashed);
    });

    test('defaults style to solid', () {
      final color = ColorToken(red: 0.0, green: 0.0, blue: 0.0);
      final token = BorderToken(width: 1.0, color: color);
      expect(token.style, BorderStyle.solid);
    });

    test('round-trips through JSON', () {
      final color = ColorToken(red: 1.0, green: 0.0, blue: 0.0);
      final original = BorderToken(width: 3.0, color: color, style: BorderStyle.dotted);
      final restored = BorderToken.fromJson(original.toJson());
      expect(restored, equals(original));
    });
  });

  group('Theme', () {
    late Theme theme;

    setUp(() {
      theme = Theme(
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
        shadows: {
          'card': ShadowToken(
            color: ColorToken.fromHex('#000000'),
            radius: 4.0,
            xOffset: 0.0,
            yOffset: 2.0,
            opacity: 0.1,
          ),
        },
        borders: {
          'default': BorderToken(
            width: 1.0,
            color: ColorToken.fromHex('#CCCCCC'),
          ),
        },
      );
    });

    test('looks up color token', () {
      expect(theme.color('primary'), isNotNull);
      expect(theme.color('primary')!.toHex(), '#3366ff');
    });

    test('looks up spacing token', () {
      expect(theme.spacing('md')!.value, 16.0);
    });

    test('looks up typography token', () {
      expect(theme.typography('body')!.fontSize, 16.0);
    });

    test('looks up shadow token', () {
      expect(theme.shadow('card')!.radius, 4.0);
    });

    test('looks up border token', () {
      expect(theme.border('default')!.width, 1.0);
    });

    test('returns null for missing token', () {
      expect(theme.color('nonexistent'), isNull);
      expect(theme.spacing('nonexistent'), isNull);
      expect(theme.typography('nonexistent'), isNull);
      expect(theme.shadow('nonexistent'), isNull);
      expect(theme.border('nonexistent'), isNull);
    });

    test('merges two themes', () {
      final dark = Theme(
        name: 'dark',
        colors: {
          'primary': ColorToken.fromHex('#6699FF'),
          'background': ColorToken.fromHex('#1A1A1A'),
        },
        spacings: {
          'lg': SpacingToken(value: 32.0),
        },
      );

      final merged = theme.merging(dark);
      expect(merged.name, 'dark');
      expect(merged.color('primary')!.toHex(), '#6699ff');
      expect(merged.color('background')!.toHex(), '#1a1a1a');
      expect(merged.spacing('sm')!.value, 8.0);
      expect(merged.spacing('lg')!.value, 32.0);
    });

    test('extends a theme', () {
      final extended = theme.extending(
        colors: {'accent': ColorToken.fromHex('#FF6633')},
      );
      expect(extended.name, 'light');
      expect(extended.color('primary'), isNotNull);
      expect(extended.color('accent'), isNotNull);
    });
  });

  group('TokenAlias', () {
    test('creates with alias and targetKey', () {
      const alias = TokenAlias(alias: 'brand', targetKey: 'primary');
      expect(alias.alias, 'brand');
      expect(alias.targetKey, 'primary');
    });

    test('equality based on both fields', () {
      const a = TokenAlias(alias: 'brand', targetKey: 'primary');
      const b = TokenAlias(alias: 'brand', targetKey: 'primary');
      const c = TokenAlias(alias: 'brand', targetKey: 'secondary');
      expect(a, equals(b));
      expect(a, isNot(equals(c)));
    });

    test('hashCode consistent with equality', () {
      const a = TokenAlias(alias: 'brand', targetKey: 'primary');
      const b = TokenAlias(alias: 'brand', targetKey: 'primary');
      expect(a.hashCode, equals(b.hashCode));
    });
  });

  group('ResponsiveToken', () {
    test('resolves breakpoint values', () {
      final token = ResponsiveToken<double>({
        'mobile': 8.0,
        'tablet': 16.0,
        'desktop': 24.0,
      });
      expect(token.resolve('mobile'), 8.0);
      expect(token.resolve('tablet'), 16.0);
      expect(token.resolve('desktop'), 24.0);
    });

    test('returns null for unknown breakpoint', () {
      final token = ResponsiveToken<double>({'mobile': 8.0});
      expect(token.resolve('desktop'), isNull);
    });

    test('lists breakpoint names', () {
      final token = ResponsiveToken<String>({
        'mobile': 'sm',
        'tablet': 'md',
        'desktop': 'lg',
      });
      expect(token.breakpointNames, ['mobile', 'tablet', 'desktop']);
    });

    test('checks breakpoint existence', () {
      final token = ResponsiveToken<int>({'mobile': 1, 'desktop': 3});
      expect(token.containsBreakpoint('mobile'), isTrue);
      expect(token.containsBreakpoint('tablet'), isFalse);
    });

    test('round-trips through JSON', () {
      final original = ResponsiveToken<double>({
        'mobile': 8.0,
        'tablet': 16.0,
        'desktop': 24.0,
      });

      final json = original.toJson((v) => v);
      final restored = ResponsiveToken.fromJson<double>(
        json,
        (v) => (v as num).toDouble(),
      );

      expect(restored.resolve('mobile'), 8.0);
      expect(restored.resolve('tablet'), 16.0);
      expect(restored.resolve('desktop'), 24.0);
      expect(restored.breakpointNames, ['mobile', 'tablet', 'desktop']);
    });
  });

  group('Theme aliases', () {
    late Theme theme;

    setUp(() {
      theme = Theme(
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
    });

    test('withAliases returns new theme with aliases', () {
      final aliased = theme.withAliases({'brand': 'primary', 'base': 'sm'});
      expect(aliased.aliases, {'brand': 'primary', 'base': 'sm'});
      expect(aliased.name, 'light');
    });

    test('resolveColor by direct name', () {
      final aliased = theme.withAliases({'brand': 'primary'});
      expect(aliased.resolveColor('primary')!.toHex(), '#3366ff');
    });

    test('resolveColor by alias', () {
      final aliased = theme.withAliases({'brand': 'primary'});
      expect(aliased.resolveColor('brand')!.toHex(), '#3366ff');
    });

    test('resolveColor returns null for unknown', () {
      final aliased = theme.withAliases({'brand': 'primary'});
      expect(aliased.resolveColor('nonexistent'), isNull);
    });

    test('resolveSpacing by alias', () {
      final aliased = theme.withAliases({'small': 'sm'});
      expect(aliased.resolveSpacing('small')!.value, 8.0);
    });

    test('resolveSpacing by direct name', () {
      final aliased = theme.withAliases({'small': 'sm'});
      expect(aliased.resolveSpacing('md')!.value, 16.0);
    });

    test('resolveTypography by alias', () {
      final aliased = theme.withAliases({'paragraph': 'body'});
      expect(aliased.resolveTypography('paragraph')!.fontSize, 16.0);
    });

    test('resolveTypography by direct name', () {
      final aliased = theme.withAliases({'paragraph': 'body'});
      expect(aliased.resolveTypography('body')!.fontSize, 16.0);
    });

    test('alias not found falls through to regular lookup returning null', () {
      final aliased = theme.withAliases({'brand': 'nonexistent'});
      expect(aliased.resolveColor('brand'), isNull);
    });

    test('aliases getter returns unmodifiable map', () {
      final aliased = theme.withAliases({'brand': 'primary'});
      expect(() => (aliased.aliases as Map)['x'] = 'y', throwsUnsupportedError);
    });
  });

  group('ThemeManager', () {
    late ThemeManager manager;
    late Theme lightTheme;
    late Theme darkTheme;

    setUp(() {
      manager = ThemeManager();
      lightTheme = Theme(name: 'light');
      darkTheme = Theme(name: 'dark');
    });

    test('registers themes', () {
      manager.register(lightTheme);
      manager.register(darkTheme);
      expect(manager.availableThemes, containsAll(['light', 'dark']));
    });

    test('switches active theme', () {
      manager.register(lightTheme);
      manager.switchTo('light');
      expect(manager.activeTheme?.name, 'light');
    });

    test('throws on switching to unregistered theme', () {
      expect(() => manager.switchTo('unknown'), throwsArgumentError);
    });

    test('has no active theme initially', () {
      expect(manager.activeTheme, isNull);
    });

    test('notifies onChange listeners', () {
      manager.register(lightTheme);
      manager.register(darkTheme);

      final changes = <String>[];
      manager.onChange((theme) => changes.add(theme.name));

      manager.switchTo('light');
      manager.switchTo('dark');
      expect(changes, ['light', 'dark']);
    });
  });

  group('TokenExporter', () {
    late TokenExporter exporter;

    setUp(() {
      exporter = TokenExporter();
    });

    test('exports and imports JSON round-trip', () {
      final theme = Theme(
        name: 'test',
        colors: {
          'primary': ColorToken.fromHex('#FF0000'),
          'secondary': ColorToken.fromHex('#00FF00'),
        },
        spacings: {
          'sm': SpacingToken(value: 4.0),
        },
        typographies: {
          'heading': TypographyToken(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            lineHeight: 1.2,
          ),
        },
        shadows: {
          'elevated': ShadowToken(
            color: ColorToken.fromHex('#000000'),
            radius: 16.0,
            xOffset: 0.0,
            yOffset: 8.0,
            opacity: 0.2,
          ),
        },
        borders: {
          'thin': BorderToken(
            width: 1.0,
            color: ColorToken.fromHex('#CCCCCC'),
            style: BorderStyle.solid,
          ),
        },
      );

      final json = exporter.exportJson(theme);
      final restored = exporter.importJson(json);

      expect(restored.name, 'test');
      expect(restored.color('primary')!.toHex(), '#ff0000');
      expect(restored.color('secondary')!.toHex(), '#00ff00');
      expect(restored.spacing('sm')!.value, 4.0);
      expect(restored.typography('heading')!.fontSize, 32.0);
      expect(restored.shadow('elevated')!.radius, 16.0);
      expect(restored.border('thin')!.width, 1.0);
    });

    test('exports and imports JSON round-trip with aliases', () {
      final theme = Theme(
        name: 'aliased',
        colors: {
          'primary': ColorToken.fromHex('#FF0000'),
        },
        spacings: {
          'sm': SpacingToken(value: 4.0),
        },
        typographies: {
          'body': TypographyToken(fontSize: 16.0, fontWeight: FontWeight.regular),
        },
        aliases: {'brand': 'primary', 'small': 'sm', 'paragraph': 'body'},
      );

      final json = exporter.exportJson(theme);
      expect(json['aliases'], {'brand': 'primary', 'small': 'sm', 'paragraph': 'body'});

      final restored = exporter.importJson(json);
      expect(restored.aliases, {'brand': 'primary', 'small': 'sm', 'paragraph': 'body'});
      expect(restored.resolveColor('brand')!.toHex(), '#ff0000');
      expect(restored.resolveSpacing('small')!.value, 4.0);
      expect(restored.resolveTypography('paragraph')!.fontSize, 16.0);
    });

    test('serializes and deserializes bytes', () {
      final theme = Theme(
        name: 'bytes-test',
        colors: {'red': ColorToken.fromHex('#FF0000')},
      );

      final bytes = exporter.serialize(theme);
      final restored = exporter.deserialize(bytes);

      expect(restored.name, 'bytes-test');
      expect(restored.color('red')!.toHex(), '#ff0000');
    });
  });

  group('TokenValidator', () {
    late TokenValidator validator;

    setUp(() {
      validator = TokenValidator();
    });

    test('passes valid theme with all required tokens', () {
      final theme = Theme(
        name: 'valid',
        colors: {
          'primary': ColorToken.fromHex('#FF0000'),
          'background': ColorToken.fromHex('#FFFFFF'),
        },
        spacings: {
          'sm': SpacingToken(value: 8.0),
        },
        typographies: {
          'body': TypographyToken(fontSize: 16.0, fontWeight: FontWeight.regular),
        },
        shadows: {
          'card': ShadowToken(
            color: ColorToken.fromHex('#000000'),
            radius: 4.0,
            xOffset: 0.0,
            yOffset: 2.0,
          ),
        },
        borders: {
          'default': BorderToken(
            width: 1.0,
            color: ColorToken.fromHex('#CCCCCC'),
          ),
        },
      );

      final issues = validator.validate(
        theme,
        requiredColors: ['primary', 'background'],
        requiredSpacing: ['sm'],
        requiredTypography: ['body'],
      );

      expect(issues, isEmpty);
    });

    test('reports missing required color tokens', () {
      final theme = Theme(name: 'incomplete', colors: {});

      final issues = validator.validate(
        theme,
        requiredColors: ['primary', 'accent'],
      );

      final errors = issues.where((i) => i.severity == Severity.error).toList();
      expect(errors, hasLength(2));
      expect(errors[0].message, contains('primary'));
      expect(errors[1].message, contains('accent'));
    });

    test('reports missing required spacing tokens', () {
      final theme = Theme(name: 'incomplete');

      final issues = validator.validate(
        theme,
        requiredSpacing: ['md'],
      );

      final errors = issues.where((i) => i.severity == Severity.error).toList();
      expect(errors.any((i) => i.message.contains('md')), isTrue);
    });

    test('reports missing required typography tokens', () {
      final theme = Theme(name: 'incomplete');

      final issues = validator.validate(
        theme,
        requiredTypography: ['heading'],
      );

      final errors = issues.where((i) => i.severity == Severity.error).toList();
      expect(errors.any((i) => i.message.contains('heading')), isTrue);
    });

    test('warns on empty token maps', () {
      final theme = Theme(name: 'empty');

      final issues = validator.validate(theme);

      final warnings = issues.where((i) => i.severity == Severity.warning).toList();
      expect(warnings, hasLength(5));
      expect(warnings.any((i) => i.message.contains('color')), isTrue);
      expect(warnings.any((i) => i.message.contains('spacing')), isTrue);
      expect(warnings.any((i) => i.message.contains('typography')), isTrue);
      expect(warnings.any((i) => i.message.contains('shadow')), isTrue);
      expect(warnings.any((i) => i.message.contains('border')), isTrue);
    });
  });

  group('Input validation', () {
    test('ColorToken rejects red out of range', () {
      expect(() => ColorToken(red: 1.5, green: 0.0, blue: 0.0), throwsA(isA<RangeError>()));
      expect(() => ColorToken(red: -0.1, green: 0.0, blue: 0.0), throwsA(isA<RangeError>()));
    });

    test('ColorToken rejects green out of range', () {
      expect(() => ColorToken(red: 0.0, green: 1.1, blue: 0.0), throwsA(isA<RangeError>()));
    });

    test('ColorToken rejects blue out of range', () {
      expect(() => ColorToken(red: 0.0, green: 0.0, blue: -0.5), throwsA(isA<RangeError>()));
    });

    test('ColorToken rejects alpha out of range', () {
      expect(() => ColorToken(red: 0.0, green: 0.0, blue: 0.0, alpha: 2.0), throwsA(isA<RangeError>()));
    });

    test('SpacingToken rejects negative value', () {
      expect(() => SpacingToken(value: -1.0), throwsA(isA<RangeError>()));
    });

    test('SpacingToken accepts zero', () {
      expect(SpacingToken(value: 0.0).value, 0.0);
    });

    test('TypographyToken rejects non-positive fontSize', () {
      expect(
        () => TypographyToken(fontSize: 0.0, fontWeight: FontWeight.regular),
        throwsA(isA<RangeError>()),
      );
      expect(
        () => TypographyToken(fontSize: -5.0, fontWeight: FontWeight.regular),
        throwsA(isA<RangeError>()),
      );
    });

    test('TypographyToken rejects non-positive lineHeight', () {
      expect(
        () => TypographyToken(fontSize: 16.0, fontWeight: FontWeight.regular, lineHeight: 0.0),
        throwsA(isA<RangeError>()),
      );
    });

    test('BorderToken rejects negative width', () {
      expect(
        () => BorderToken(width: -1.0, color: ColorToken(red: 0.0, green: 0.0, blue: 0.0)),
        throwsA(isA<RangeError>()),
      );
    });

    test('BorderToken accepts zero width', () {
      final token = BorderToken(width: 0.0, color: ColorToken(red: 0.0, green: 0.0, blue: 0.0));
      expect(token.width, 0.0);
    });

    test('ShadowToken rejects negative radius', () {
      expect(
        () => ShadowToken(
          color: ColorToken(red: 0.0, green: 0.0, blue: 0.0),
          radius: -1.0,
          xOffset: 0.0,
          yOffset: 0.0,
        ),
        throwsA(isA<RangeError>()),
      );
    });

    test('ShadowToken rejects opacity out of range', () {
      expect(
        () => ShadowToken(
          color: ColorToken(red: 0.0, green: 0.0, blue: 0.0),
          radius: 4.0,
          xOffset: 0.0,
          yOffset: 0.0,
          opacity: 1.5,
        ),
        throwsA(isA<RangeError>()),
      );
    });
  });

  group('TokenValidator shadows and borders', () {
    late TokenValidator validator;

    setUp(() {
      validator = TokenValidator();
    });

    test('reports missing required shadow tokens', () {
      final theme = Theme(name: 'test');
      final issues = validator.validate(
        theme,
        requiredShadows: ['card', 'dropdown'],
      );
      final errors = issues.where((i) => i.severity == Severity.error).toList();
      expect(errors, hasLength(2));
      expect(errors[0].message, contains('card'));
      expect(errors[1].message, contains('dropdown'));
    });

    test('reports missing required border tokens', () {
      final theme = Theme(name: 'test');
      final issues = validator.validate(
        theme,
        requiredBorders: ['default', 'focus'],
      );
      final errors = issues.where((i) => i.severity == Severity.error).toList();
      expect(errors, hasLength(2));
      expect(errors[0].message, contains('default'));
      expect(errors[1].message, contains('focus'));
    });

    test('passes when required shadows and borders exist', () {
      final theme = Theme(
        name: 'complete',
        shadows: {
          'card': ShadowToken(
            color: ColorToken(red: 0.0, green: 0.0, blue: 0.0),
            radius: 4.0,
            xOffset: 0.0,
            yOffset: 2.0,
          ),
        },
        borders: {
          'default': BorderToken(
            width: 1.0,
            color: ColorToken(red: 0.5, green: 0.5, blue: 0.5),
          ),
        },
      );
      final issues = validator.validate(
        theme,
        requiredShadows: ['card'],
        requiredBorders: ['default'],
      );
      final errors = issues.where((i) => i.severity == Severity.error).toList();
      expect(errors, isEmpty);
    });

    test('warns on empty shadow and border maps', () {
      final theme = Theme(name: 'empty');
      final issues = validator.validate(theme);
      final warnings = issues.where((i) => i.severity == Severity.warning).toList();
      expect(warnings.any((i) => i.message.contains('shadow')), isTrue);
      expect(warnings.any((i) => i.message.contains('border')), isTrue);
    });
  });

  group('Theme immutability', () {
    test('external map mutation does not affect theme', () {
      final colors = {'primary': ColorToken.fromHex('#FF0000')};
      final theme = Theme(name: 'test', colors: colors);
      colors['secondary'] = ColorToken.fromHex('#00FF00');
      expect(theme.colors.containsKey('secondary'), isFalse);
    });

    test('theme color map is unmodifiable', () {
      final theme = Theme(
        name: 'test',
        colors: {'primary': ColorToken.fromHex('#FF0000')},
      );
      expect(
        () => (theme.colors as Map)['x'] = ColorToken.fromHex('#000000'),
        throwsUnsupportedError,
      );
    });
  });
}
