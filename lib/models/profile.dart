// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    ProfileModel({
        this.phoneNumber = "",
        this.userRole = "",
        this.subscription = "",
       required this.createdAt ,
        this.fullName = "",
        this.state = "",
        this.city = "",
        this.isActive = false,
        this.userId = "",
        this.profilePicture = "",
        required this.updatedAt,
        this.zipCode = 00000,
        this.street = "",
        this.id = "",
        this.hourlyFee = 0,
        this.diagnosticFee = 0,
        this.isOnline = false
    });

    String phoneNumber;
    String userRole;
    String subscription;
    DateTime createdAt;
    String fullName;
    String state;
    String city;
    bool isActive;
    String userId;
    String profilePicture;
    DateTime updatedAt;
    int zipCode;
    String street;
    String id;
    int hourlyFee;
    int diagnosticFee;
    bool isOnline;

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        phoneNumber: json["phoneNumber"],
        userRole: json["userRole"],
        subscription: json["subscription"],
        createdAt: DateTime.parse(json["createdAt"]),
        fullName: json["fullName"],
        state: json["state"],
        city: json["city"],
        isActive: json["isActive"],
        userId: json["userID"],
        profilePicture: json["profilePicture"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        zipCode: json["zipCode"],
        street: json["street"],
        id: json["id"],
        hourlyFee: json["hourlyFee"],
        diagnosticFee: json["diagnosticFee"],
        isOnline: json["isOnline"]

    );

    Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "userRole": userRole,
        "subscription": subscription,
        "createdAt": createdAt.toIso8601String(),
        "fullName": fullName,
        "state": state,
        "city": city,
        "isActive": isActive,
        "userID": userId,
        "profilePicture": profilePicture,
        "updatedAt": updatedAt.toIso8601String(),
        "zipCode": zipCode,
        "street": street,
        "id" :id,
        "horlyFee" :hourlyFee,
        "diagnosticFee":diagnosticFee,
        "isOnline":isOnline
    };
}
