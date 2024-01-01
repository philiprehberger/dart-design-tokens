/// A spacing token representing a distance value.
class SpacingToken {
  /// The spacing value in logical pixels.
  final double value;

  /// Creates a [SpacingToken] with the given [value].
  const SpacingToken({required this.value});

  /// Converts this token to a JSON-serializable map.
  Map<String, dynamic> toJson() => {'value': value};

  /// Creates a [SpacingToken] from a JSON map.
  factory SpacingToken.fromJson(Map<String, dynamic> json) =>
      SpacingToken(value: (json['value'] as num).toDouble());

  @override
  String toString() => 'SpacingToken($value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SpacingToken && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
