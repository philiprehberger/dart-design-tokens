# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.0] - 2026-04-28

### Added
- `ColorToken.relativeLuminance` getter computing WCAG 2.1 relative luminance
- `ColorToken.contrastRatio()` for WCAG 2.1 contrast ratio between two colors
- `ColorToken.meetsWcagAA()` for WCAG 2.1 AA contrast compliance (normal and large text)
- `ColorToken.meetsWcagAAA()` for WCAG 2.1 AAA contrast compliance (normal and large text)

### Changed
- README Requirements now correctly states `Dart >= 3.6`

## [0.3.0] - 2026-04-02

### Added
- Input validation on all token constructors (ColorToken, SpacingToken, TypographyToken, BorderToken, ShadowToken)
- `TokenValidator.validate()` now supports `requiredShadows` and `requiredBorders` parameters
- Empty shadow and border token maps now generate validation warnings
- Theme token maps are now unmodifiable after construction

## [0.2.0] - 2026-04-02

### Added
- `TokenAlias` class for defining alternative token names
- `ResponsiveToken<T>` for breakpoint-dependent token values
- `Theme.withAliases()` to register semantic aliases
- `Theme.resolveColor()`, `resolveSpacing()`, `resolveTypography()` — resolve by name or alias
- `TokenExporter` now includes aliases in JSON output

## [0.1.0] - 2026-04-01

### Added
- `ColorToken` with RGBA values and hex string parsing/serialization
- `SpacingToken` for consistent spacing values
- `TypographyToken` with font size, weight, line height, and letter spacing
- `ShadowToken` with color, radius, offsets, and opacity
- `BorderToken` with width, color, and border style (solid, dashed, dotted)
- `Theme` class with named token maps and lookup methods
- Theme merging and extending for composable design systems
- `ThemeManager` for registering, switching, and observing theme changes
- `TokenExporter` for JSON round-trip serialization and deserialization
- `TokenValidator` for validating themes against required token sets
- Zero external dependencies
