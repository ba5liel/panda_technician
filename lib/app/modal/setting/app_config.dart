import 'dart:convert';

class AppConfig {
  final String baseURL;
  AppConfig({
    required this.baseURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'BASE_URL': baseURL,
    };
  }

  factory AppConfig.fromMap(Map<String, dynamic> map) {
    return AppConfig(
      baseURL: map['BASE_URL'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppConfig.fromJson(String source) =>
      AppConfig.fromMap(json.decode(source));
}
