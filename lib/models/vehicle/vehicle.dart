// To parse this JSON data, do
//
//     final vehicle = vehicleFromJson(jsonString);

import 'dart:convert';

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  final DateTime now = DateTime.now();
    Vehicle({
        this.model = "",
       required this.createdAt,
        this.brand = "",
        this.email = "",
       this.make = "",
        this.image = "",
       required this.updatedAt ,
        this.isFavorite = false,
        this.plateNumber = 000,
        this.description = "",
        this.id = "",
        this.color = "",
        this.transmission = "",
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

    factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
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
