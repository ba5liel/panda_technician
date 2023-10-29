import 'dart:convert';

import 'package:panda_technician/models/offer.dart';

List<RejectedOffer> RejectedOfferFromJson(String str) => List<RejectedOffer>.from(json.decode(str)["Items"].map((x) => RejectedOffer.fromJson(x)));

String RejectedOfferToJson(List<RejectedOffer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RejectedOffer {
    RejectedOffer({
        this.isApproved = false,
        this.createdAt = "",
        this.vat = 0,
        this.requestId = "",
        this.sender = "",
        required this.items ,
        this.totalEstimation = "",
        this.note = "",
        this.updatedAt = "",
        this.id = "",
        this.isRejected =false,
        this.title = "",
         this.discount = 0.0,
        this.isCounterOffer = false
    });

    bool isApproved;
    String createdAt;
    double vat;
    String requestId;
    String sender;
    List<Item> items;
    String totalEstimation;
    String note;
    String updatedAt;
    String id;
    bool isRejected;
    String title;
     double discount;
    bool isCounterOffer;

    factory RejectedOffer.fromJson(Map<String, dynamic> json) => RejectedOffer(
        isApproved: json["isApproved"],
        createdAt: json["createdAt"],
        vat: double.parse(json["vat"]),
        requestId: json["requestId"],
        sender: json["sender"],
        items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
        totalEstimation: json["totalEstimation"],
        note: json["note"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        isRejected: json["isRejected"],
        title: json["title"],
         discount: json["discount"],
        isCounterOffer: json["isCounterOffer"]
    );

    Map<String, dynamic> toJson() => {
        "isApproved": isApproved,
        "createdAt": createdAt,
        "vat": vat,
        "requestId": requestId,
        "sender": sender,
        "Items": List<dynamic>.from(items.map((x) => x.toJson())),
        "totalEstimation": totalEstimation,
        "note": note,
        "updatedAt": updatedAt,
        "id": id,
        "isRejected": isRejected,
        "title": title,
           "discount":discount,
        "isCounterOffer":isCounterOffer
    };
}


