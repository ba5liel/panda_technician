// To parse this JSON data, do
//
//     final detailedRequestM = detailedRequestMFromJson(jsonString);

import 'dart:convert';

import 'package:panda_technician/models/globalModels/description.dart';
import 'package:panda_technician/models/globalModels/price.dart';
import 'package:panda_technician/models/globalModels/schedule.dart';
import 'package:panda_technician/models/globalModels/serviceLocation.dart';

class DetailedRequestM {
  String id;
  List<dynamic> vehicleId;
  String technicianId;
  String requestStatus;
  DateTime createdAt;
  Schedule schedule;
  ServiceLocation serviceLocation;
  DateTime updatedAt;
  String serviceId;
  Price price;
  Description description;
  String customerId;
  Info customerInfo;
  Info technicianInfo;
  DetailedRequestM({
    required this.id,
    required this.vehicleId,
    required this.technicianId,
    required this.requestStatus,
    required this.createdAt,
    required this.schedule,
    required this.serviceLocation,
    required this.updatedAt,
    required this.serviceId,
    required this.price,
    required this.description,
    required this.customerId,
    required this.customerInfo,
    required this.technicianInfo,
  });
  // SentOffer sentOffer;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'technicianId': technicianId,
      'requestStatus': requestStatus,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'schedule': schedule.toJson(),
      'serviceLocation': serviceLocation.toJson(),
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'serviceId': serviceId,
      'price': price.toJson(),
      'description': description.toJson(),
      'customerId': customerId,
      'customerInfo': customerInfo.toJson(),
      'technicianInfo': technicianInfo.toJson(),
    };
  }

  factory DetailedRequestM.fromMap(Map<String, dynamic> map) {
    return DetailedRequestM(
      id: map['id'] ?? '',
      vehicleId: List<dynamic>.from(map['vehicleId']),
      technicianId: map['technicianId'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      schedule: Schedule.fromJson(map['schedule']),
      serviceLocation: ServiceLocation.fromJson(map['serviceLocation']),
      updatedAt: DateTime.parse(map['updatedAt']),
      serviceId: map['serviceId'] ?? '',
      price: Price.fromJson(map['price']),
      description: Description.fromJson(map['description']),
      customerId: map['customerId'] ?? '',
      customerInfo: Info.fromJson(map['customerInfo']),
      technicianInfo: Info.fromJson(map['technicianInfo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailedRequestM.fromJson(String source) =>
      DetailedRequestM.fromMap(json.decode(source));
}

class Info {
  Info({
    this.phoneNumber = "",
    this.userRole = "",
    this.subscription = "",
    required this.createdAt,
    this.fullName = "",
    this.state = "",
    this.city = "",
    this.isActive = false,
    this.userId = "",
    this.profilePicture = "",
    required this.updatedAt,
    this.id = "",
    this.zipCode = 000,
    this.street = "",
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
  String id;
  int zipCode;
  String street;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
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
        id: json["id"],
        zipCode: json["zipCode"],
        street: json["street"],
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
        "id": id,
        "zipCode": zipCode,
        "street": street,
      };
}
