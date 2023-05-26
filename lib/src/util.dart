import 'dart:convert';
import 'dart:io';

class Util {
  static String? toJSON(dynamic data) {
    try {
      return jsonEncode(data);
    } catch (e) {
      return null;
    }
  }

  static String getSystemHostname() {
    String name = Platform.localHostname;

    if (name.isEmpty) {
      name = 'unknown';
    }

    return name;
  }

  static String getSystemUsername() {
    return Platform.environment['USER'] ?? 'unknown';
  }
}
