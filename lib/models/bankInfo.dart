// To parse this JSON data, do
//
//     final bankInfo = bankInfoFromJson(jsonString);

import 'dart:convert';

List<BankInfo> bankInfoFromJson(String str) => List<BankInfo>.from(json.decode(str).map((x) => BankInfo.fromJson(x)));

String bankInfoToJson(List<BankInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankInfo {
    BankInfo({
       required this.isActive,
       required this.routingNumber,
       required this.w9,
       required this.updatedAt,
       required this.createdAt,
       required this.bankName,
       required this.email,
       required this.id,
    });

    bool isActive;
    String routingNumber;
    String w9;
    DateTime updatedAt;
    DateTime createdAt;
    String bankName;
    String email;
    String id;

    factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        isActive: json["isActive"],
        routingNumber: json["routingNumber"],
        w9: json["w9"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        bankName: json["bankName"],
        email: json["email"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "routingNumber": routingNumber,
        "w9": w9,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "bankName": bankName,
        "email": email,
        "id": id,
    };
}
