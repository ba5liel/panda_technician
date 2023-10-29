// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

Offer offersFromJson(String str) => Offer.fromJson(json.decode(str));

String offersToJson(Offer data) => json.encode(data.toJson());

class Offer {
  Offer(
      {this.requestId = "",
      this.title = "",
      this.note = "",
      required this.items,
      this.totalEstimation = "",
      this.sender = "",
      this.createdAt = "",
      this.vat = 0.0,
      this.id = "",
      this.discount = 0.0,
      this.isCounterOffer = false,
      this.isApproved = false,
      this.isRejected = false});

  String requestId;
  String title;
  String note;
  List<Item> items;
  String totalEstimation;
  String sender;
  String createdAt;
  double vat;
  String id;
  double discount;
  bool isCounterOffer;
  bool isApproved;
  bool isRejected;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
      requestId: json["requestId"],
      title: json["title"],
      note: json["note"],
      items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
      totalEstimation: json["totalEstimation"],
      sender: json["sender"],
      createdAt: json["createdAt"],
      vat: json["vat"] ?? 0.0,
      id: json["id"],
      discount: json["discount"],
      isCounterOffer: json["isCounterOffer"],
      isApproved: json["isApproved"] ?? false);

  Map<String, dynamic> toJson() => {
        "requestId": requestId,
        "title": title,
        "note": note,
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalEstimation": totalEstimation,
        "sender": sender,
        "createdAt": createdAt,
        "vat": vat,
        "id": id,
        "discount": discount,
        "isCounterOffer": isCounterOffer,
        "isApproved": isApproved
      };
}
// "sender": sender,
//         "Items": List<Item>.from(items.map((x) => x.toJson())),
//         "totalEstimation": totalEstimation,
//         "note": note,
//         "isApproved": isApproved,
//         "updatedAt": updatedAt,
//         "createdAt": createdAt,
//         "id": id,
//         "requestId": requestId,
//         "title": title,
//         "isRejected":isRejected

class Item {
  Item({
    required this.title,
    required this.price,
  });

  String title;
  String price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
      };
}
