// To parse this JSON data, do
//
//     final canceld = canceldFromJson(jsonString);

import 'dart:convert';

List<Canceld> canceldFromJson(String str) => List<Canceld>.from(json.decode(str).map((x) => Canceld.fromJson(x)));

String canceldToJson(List<Canceld> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Canceld {
    Canceld({
       required this.createdAt,
       required this.id,
       required this.technicianId,
       required this.updatedAt,
       required this.requestId,
    });

    DateTime createdAt;
    String id;
    String technicianId;
    DateTime updatedAt;
    String requestId;

    factory Canceld.fromJson(Map<String, dynamic> json) => Canceld(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        technicianId: json["technicianId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        requestId: json["requestId"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "technicianId": technicianId,
        "updatedAt": updatedAt.toIso8601String(),
        "requestId": requestId,
    };
}
