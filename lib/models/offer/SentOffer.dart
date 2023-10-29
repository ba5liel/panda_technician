// To parse this JSON data, do
//
//     final sentOffer = sentOfferFromJson(jsonString);

import 'dart:convert';

import 'package:panda_technician/models/offer.dart';

List<SentOffer> sentOfferFromJson(String str) =>
    List<SentOffer>.from(json.decode(str).map((x) => SentOffer.fromJson(x)));

String sentOfferToJson(List<SentOffer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SentOffer {
  SentOffer(
      {this.sender = "",
      required this.items,
      this.totalEstimation = "",
      this.note = "",
      this.isApproved = false,
      this.updatedAt = "",
      this.createdAt = "",
      this.id = "",
      this.requestId = "",
      this.title = "",
      this.isRejected = false,
      this.discount = 0.0,
      this.isCounterOffer = false,
      this.vat = 0.0});

  String sender;
  List<Item> items;
  String totalEstimation;
  String note;
  bool isApproved;
  String updatedAt;
  String createdAt;
  String id;
  String requestId;
  String title;
  bool isRejected;
  double discount;
  bool isCounterOffer;
  double vat;

  factory SentOffer.fromJson(Map<String, dynamic> json) => SentOffer(
      sender: json["sender"],
      items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
      totalEstimation: json["totalEstimation"],
      note: json["note"],
      isApproved: json["isApproved"],
      updatedAt: json["updatedAt"],
      createdAt: json["createdAt"],
      id: json["id"],
      requestId: json["requestId"],
      title: json["title"],
      isRejected: json["isRejected"],
      discount: json["discount"].toDouble(),
      isCounterOffer: json["isCounterOffer"],
      vat: json["vat"].toDouble());

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "Items": List<Item>.from(items.map((x) => x.toJson())),
        "totalEstimation": totalEstimation,
        "note": note,
        "isApproved": isApproved,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
        "id": id,
        "requestId": requestId,
        "title": title,
        "isRejected": isRejected,
        "discount": discount,
        "isCounterOffer": isCounterOffer,
        "vat": vat
      };
}

// class Item {
//     Item({
//         this.title = "" ,
//         this.price = "" ,
//     });

//     String title;
//     String price;

//     factory Item.fromJson(Map<String, dynamic> json) => Item(
//         title: json["title"],
//         price: json["price"],
//     );

//     Map<String, dynamic> toJson() => {
//         "title": title,
//         "price": price,
//     };
// }
