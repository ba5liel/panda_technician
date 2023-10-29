// To parse this JSON data, do
//
//     final statusRequest = statusRequestFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:panda_technician/models/globalModels/description.dart';
import 'package:panda_technician/models/globalModels/price.dart';
import 'package:panda_technician/models/globalModels/schedule.dart';
import 'package:panda_technician/models/globalModels/serviceLocation.dart';
import 'package:panda_technician/models/offer/SentOffer.dart';
import 'package:panda_technician/models/requests/detailedRequestM.dart';

class ServiceRequestModel {
  List<String> vehicleId;
  String technicianId;
  DateTime createdAt;
  Schedule schedule;
  ServiceLocation serviceLocation;
  DateTime updatedAt;
  String serviceId;
  Price price;
  Description description;
  String id;
  String requestStatus;
  String customerId;
  List<VehiclesDetail>? vehiclesDetail;
  ServiceDetail serviceDetail;
  bool isScheduled;
  Info customerInfo;
  Info? technicianInfo;
  List<SentOffer>? offerDetail;

  ServiceRequestModel({
    required this.vehicleId,
    required this.technicianId,
    required this.createdAt,
    required this.schedule,
    required this.serviceLocation,
    required this.updatedAt,
    required this.serviceId,
    required this.price,
    required this.description,
    required this.id,
    required this.requestStatus,
    required this.customerId,
    required this.vehiclesDetail,
    required this.serviceDetail,
    required this.isScheduled,
    required this.customerInfo,
    required this.technicianInfo,
    required this.offerDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      'vehicleId': vehicleId,
      'technicianId': technicianId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'schedule': schedule.toJson(),
      'serviceLocation': serviceLocation.toJson(),
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'serviceId': serviceId,
      'price': price.toJson(),
      'description': description.toJson(),
      'id': id,
      'requestStatus': requestStatus,
      'customerId': customerId,
      'vehiclesDetail': vehiclesDetail?.map((x) => x.toJson()).toList(),
      'serviceDetail': serviceDetail.toJson(),
      'isScheduled': isScheduled,
      'customerInfo': customerInfo.toJson(),
      'technicianInfo': technicianInfo?.toJson(),
      'offerDetail': offerDetail!.map((x) => x.toJson()).toList(),
    };
  }

  factory ServiceRequestModel.fromMap(Map<String, dynamic> map) {
    return ServiceRequestModel(
      vehicleId: List<String>.from(map['vehicleId']),
      technicianId: map['technicianId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      schedule: Schedule.fromJson(map['schedule']),
      serviceLocation: ServiceLocation.fromJson(map['serviceLocation']),
      updatedAt: DateTime.parse(map['updatedAt']),
      serviceId: map['serviceId'] ?? '',
      price: Price.fromJson(map['price']),
      description: Description.fromJson(map['description']),
      id: map['id'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
      customerId: map['customerId'] ?? '',
      vehiclesDetail:
          (map['vehiclesDetail'] != null && !map['vehiclesDetail'].isEmpty)
              ? List<VehiclesDetail>.from(
                  map['vehiclesDetail']?.map((x) => VehiclesDetail.fromJson(x)))
              : null,
      serviceDetail: ServiceDetail.fromJson(map['serviceDetail']),
      isScheduled: map['isScheduled'] ?? false,
      customerInfo: Info.fromJson(map['customerInfo']),
      technicianInfo: (map['technicianInfo'] != null &&
              !map['technicianInfo'].entries.isEmpty)
          ? Info.fromJson(map['technicianInfo'])
          : null,
      offerDetail: map['offerDetail'] == null
          ? null
          : List<SentOffer>.from(
              map['offerDetail']?.map((x) => SentOffer.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceRequestModel.fromJson(String source) =>
      ServiceRequestModel.fromMap(json.decode(source));
}

class VehiclesDetail {
  VehiclesDetail({
    required this.model,
    required this.createdAt,
    required this.brand,
    required this.email,
    required this.make,
    required this.image,
    required this.updatedAt,
    required this.isFavorite,
    required this.plateNumber,
    required this.description,
    required this.id,
    required this.color,
    required this.transmission,
  });

  String model;
  DateTime createdAt;
  String brand;
  String email;
  String make;
  String image;
  DateTime updatedAt;
  bool isFavorite;
  int plateNumber;
  String description;
  String id;
  String color;
  String transmission;

  factory VehiclesDetail.fromJson(Map<String, dynamic> json) => VehiclesDetail(
        model: json["model"],
        createdAt: DateTime.parse(json["createdAt"]),
        brand: json["brand"],
        email: json["email"],
        make: json["make"],
        image: json["image"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        isFavorite: json["isFavorite"],
        plateNumber: json["plateNumber"],
        description: json["description"],
        id: json["id"],
        color: json["color"],
        transmission: json["transmission"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "createdAt": createdAt.toIso8601String(),
        "brand": brand,
        "email": email,
        "make": make,
        "image": image,
        "updatedAt": updatedAt.toIso8601String(),
        "isFavorite": isFavorite,
        "plateNumber": plateNumber,
        "description": description,
        "id": id,
        "color": color,
        "transmission": transmission,
      };
}

class ServiceDetail {
  ServiceDetail({
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

  factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
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
