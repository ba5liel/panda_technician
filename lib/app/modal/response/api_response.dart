import 'dart:convert';

class APIResponse<T> {
  final bool success;
  final dynamic data;
  final String? msg;
  APIResponse({
    required this.success,
    required this.data,
    this.msg,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'data': data,
      'msg': msg,
    };
  }

  factory APIResponse.fromMap(Map<String, dynamic> map) {
    return APIResponse<T>(
      success: map['success'] ?? false,
      data: map['data'],
      msg: map['msg'],
    );
  }

  String toJson() => json.encode(toMap());

  factory APIResponse.fromJson(String source) =>
      APIResponse.fromMap(json.decode(source));
}
