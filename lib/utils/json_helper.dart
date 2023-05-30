class ParserUtil<T> {
  static DateTime parseJsonDate(String? dateString) {
    try {
      return DateTime.parse(dateString!);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String parseJsonString(
    Object? json,
    String param, {
    String? defaultValue,
    bool isTitleCase = false,
  }) {
    try {
      json = json as Map;
      Object? result = json[param];

      if (result == null) return defaultValue ?? '';

      String resultString = result.toString();
      final parsedString =
          resultString.isEmpty ? defaultValue ?? resultString : resultString;

      if (isTitleCase) return parsedString;
      return parsedString;
    } catch (e) {
      if (isTitleCase) return defaultValue ?? '';
      return defaultValue ?? '';
    }
  }

  List<T> parseJsonList({
    required List<dynamic>? json,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    try {
      final data = List<Map<String, dynamic>>.from(json!);

      return List<T>.from(
        data.map(
          (e) => fromJson(e),
        ),
      );
    } catch (e) {
      //AppLogger.log(e);
      return [];
    }
  }

  static num parseJsonNum(Map? json, String param) {
    try {
      Object? result = json![param];

      if (result == null) return 0;
      if (result is String) return num.parse(result);
      return result as num;
    } catch (e) {
      return 0;
    }
  }
}
