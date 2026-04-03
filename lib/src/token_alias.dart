/// A token alias that maps an alternative name to an existing token key.
class TokenAlias {
  /// The alias name.
  final String alias;

  /// The target token key this alias refers to.
  final String targetKey;

  /// Creates a [TokenAlias] mapping [alias] to [targetKey].
  const TokenAlias({required this.alias, required this.targetKey});

  @override
  String toString() => 'TokenAlias($alias -> $targetKey)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAlias &&
          alias == other.alias &&
          targetKey == other.targetKey;

  @override
  int get hashCode => Object.hash(alias, targetKey);
}
