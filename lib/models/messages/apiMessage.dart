import 'dart:convert';

ApiMessage apiMessageFromJson(String str) => ApiMessage.fromJson(json.decode(str));

String apiMessageToJson(ApiMessage data) => json.encode(data.toJson());

class ApiMessage {
    ApiMessage({
        this.code = 0,
        this.data = "",
    });

    int code;
    String data;

    factory ApiMessage.fromJson(Map<String, dynamic> json) => ApiMessage(
        code: json["code"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": data,
    };
}
