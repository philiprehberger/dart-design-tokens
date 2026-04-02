import 'theme.dart';

/// The severity of a validation issue.
enum Severity {
  /// A non-critical issue.
  warning,

  /// A critical issue.
  error,
}

/// A single validation issue found in a theme.
class ValidationIssue {
  /// The severity of this issue.
  final Severity severity;

  /// A description of the issue.
  final String message;

  /// Creates a [ValidationIssue].
  const ValidationIssue({required this.severity, required this.message});

  @override
  String toString() => '${severity.name}: $message';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValidationIssue &&
          severity == other.severity &&
          message == other.message;

  @override
  int get hashCode => Object.hash(severity, message);
}

/// Validates themes against required token sets.
class TokenValidator {
  /// Validates a [theme] against required token names.
  ///
  /// Returns a list of [ValidationIssue]s. An empty list means the theme
  /// passes validation.
  ///
  /// Missing required colors, spacings, and typographies are reported as
  /// errors. Empty token maps generate warnings.
  List<ValidationIssue> validate(
    Theme theme, {
    List<String> requiredColors = const [],
    List<String> requiredSpacing = const [],
    List<String> requiredTypography = const [],
  }) {
    final issues = <ValidationIssue>[];

    for (final name in requiredColors) {
      if (!theme.colors.containsKey(name)) {
        issues.add(ValidationIssue(
          severity: Severity.error,
          message: 'Missing required color token: $name',
        ));
      }
    }

    for (final name in requiredSpacing) {
      if (!theme.spacings.containsKey(name)) {
        issues.add(ValidationIssue(
          severity: Severity.error,
          message: 'Missing required spacing token: $name',
        ));
      }
    }

    for (final name in requiredTypography) {
      if (!theme.typographies.containsKey(name)) {
        issues.add(ValidationIssue(
          severity: Severity.error,
          message: 'Missing required typography token: $name',
        ));
      }
    }

    if (theme.colors.isEmpty) {
      issues.add(const ValidationIssue(
        severity: Severity.warning,
        message: 'Theme has no color tokens',
      ));
    }

    if (theme.spacings.isEmpty) {
      issues.add(const ValidationIssue(
        severity: Severity.warning,
        message: 'Theme has no spacing tokens',
      ));
    }

    if (theme.typographies.isEmpty) {
      issues.add(const ValidationIssue(
        severity: Severity.warning,
        message: 'Theme has no typography tokens',
      ));
    }

    return issues;
  }
}
