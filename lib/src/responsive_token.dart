/// A token that holds different values for different breakpoints.
///
/// Use this to define responsive design tokens that vary by screen size
/// or other breakpoint conditions (e.g., 'mobile', 'tablet', 'desktop').
class ResponsiveToken<T> {
  final Map<String, T> _breakpoints;

  /// Creates a [ResponsiveToken] with values keyed by breakpoint name.
  ResponsiveToken(Map<String, T> breakpoints)
      : _breakpoints = Map.unmodifiable(breakpoints);

  /// Returns the value for the given [breakpoint], or `null` if not found.
  T? resolve(String breakpoint) => _breakpoints[breakpoint];

  /// Returns all breakpoint names.
  List<String> get breakpointNames => _breakpoints.keys.toList();

  /// Returns `true` if the given [breakpoint] exists.
  bool containsBreakpoint(String breakpoint) =>
      _breakpoints.containsKey(breakpoint);

  /// Converts this token to a JSON-serializable map.
  ///
  /// The [serializer] converts each value of type [T] to a JSON-safe value.
  Map<String, dynamic> toJson(dynamic Function(T) serializer) =>
      _breakpoints.map((k, v) => MapEntry(k, serializer(v)));

  /// Creates a [ResponsiveToken] from a JSON map.
  ///
  /// The [deserializer] converts each JSON value back to type [T].
  static ResponsiveToken<T> fromJson<T>(
    Map<String, dynamic> json,
    T Function(dynamic) deserializer,
  ) =>
      ResponsiveToken<T>(
        json.map((k, v) => MapEntry(k, deserializer(v))),
      );

  @override
  String toString() => 'ResponsiveToken(${_breakpoints.keys.join(', ')})';
}
