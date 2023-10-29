// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
    Service({
       required this.createdAt,
       required this.description,
       required this.id,
       required this.updatedAt,
       required this.title,
    });

    DateTime createdAt;
    String description;
    String id;
    DateTime updatedAt;
    String title;

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        createdAt: DateTime.parse(json["createdAt"]),
        description: json["description"],
        id: json["id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "description": description,
        "id": id,
        "updatedAt": updatedAt.toIso8601String(),
        "title": title,
    };
}
