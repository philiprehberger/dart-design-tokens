import 'theme.dart';

/// Callback invoked when the active theme changes.
typedef ThemeChangeCallback = void Function(Theme theme);

/// Manages multiple themes with registration, switching, and change notification.
class ThemeManager {
  final Map<String, Theme> _themes = {};
  Theme? _activeTheme;
  final List<ThemeChangeCallback> _listeners = [];

  /// The currently active theme, or `null` if none is set.
  Theme? get activeTheme => _activeTheme;

  /// Returns the names of all registered themes.
  List<String> get availableThemes => _themes.keys.toList();

  /// Registers a [theme]. Replaces any existing theme with the same name.
  void register(Theme theme) {
    _themes[theme.name] = theme;
  }

  /// Switches the active theme to the one registered with [name].
  ///
  /// Throws [ArgumentError] if no theme with that name is registered.
  void switchTo(String name) {
    final theme = _themes[name];
    if (theme == null) {
      throw ArgumentError('No theme registered with name: $name');
    }
    _activeTheme = theme;
    for (final listener in _listeners) {
      listener(theme);
    }
  }

  /// Adds a callback that is invoked whenever the active theme changes.
  void onChange(ThemeChangeCallback callback) {
    _listeners.add(callback);
  }

  /// Removes a previously added change callback.
  void removeListener(ThemeChangeCallback callback) {
    _listeners.remove(callback);
  }
}
