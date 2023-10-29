import 'dart:convert';

class SubscriptionRequestEvent {
  final String id;
  final String technicianId;
  final String customerId;
  final String requestStatus;
  SubscriptionRequestEvent({
    required this.id,
    required this.technicianId,
    required this.customerId,
    required this.requestStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'technicianId': technicianId,
      'customerId': customerId,
      'requestStatus': requestStatus,
    };
  }

  factory SubscriptionRequestEvent.fromMap(Map<String, dynamic> map) {
    return SubscriptionRequestEvent(
      id: map['id'] ?? '',
      technicianId: map['technicianId'] ?? '',
      customerId: map['customerId'] ?? '',
      requestStatus: map['requestStatus'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionRequestEvent.fromJson(String source) =>
      SubscriptionRequestEvent.fromMap(json.decode(source));
}
