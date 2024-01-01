import 'dart:convert';
import 'dart:typed_data';

import 'theme.dart';

/// Handles JSON serialization and deserialization of themes.
class TokenExporter {
  /// Exports a [theme] to a JSON-serializable map.
  Map<String, dynamic> exportJson(Theme theme) => theme.toJson();

  /// Imports a [Theme] from a JSON map.
  Theme importJson(Map<String, dynamic> json) => Theme.fromJson(json);

  /// Serializes a [theme] to UTF-8 JSON bytes.
  Uint8List serialize(Theme theme) {
    final json = exportJson(theme);
    final encoded = jsonEncode(json);
    return Uint8List.fromList(utf8.encode(encoded));
  }

  /// Deserializes a [Theme] from UTF-8 JSON bytes.
  Theme deserialize(Uint8List bytes) {
    final decoded = utf8.decode(bytes);
    final json = jsonDecode(decoded) as Map<String, dynamic>;
    return importJson(json);
  }
}
