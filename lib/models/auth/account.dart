import 'dart:convert';

class UserAccount {
  final String id;
  final String connectAccountId;
  final String fullName;
  final bool isActive;
  final String phoneNumber;
  final String city;
  final String state;
  final String street;
  final int zipCode;
  final String subscription;
  final String profilePicture;
  final String email;
  final String userID;
  final String userRole;
  final String verification;
  final String fcmToken;
  final String createdAt;
  final String updatedAt;
  UserAccount({
    required this.id,
    required this.connectAccountId,
    required this.fullName,
    required this.isActive,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.street,
    required this.zipCode,
    required this.subscription,
    required this.profilePicture,
    required this.email,
    required this.userID,
    required this.userRole,
    required this.verification,
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'connect_account_id': connectAccountId,
      'fullName': fullName,
      'isActive': isActive,
      'phoneNumber': phoneNumber,
      'city': city,
      'state': state,
      'street': street,
      'zipCode': zipCode,
      'subscription': subscription,
      'profilePicture': profilePicture,
      'email': email,
      'userID': userID,
      'userRole': userRole,
      'verification': verification,
      'fcm_token': fcmToken,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserAccount.fromMap(Map<String, dynamic> map) {
    return UserAccount(
      id: map['id'] ?? '',
      connectAccountId: map['connect_account_id'] ?? '',
      fullName: map['fullName'] ?? '',
      isActive: map['isActive'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      street: map['street'] ?? '',
      zipCode: map['zipCode'] ?? 1000,
      subscription: map['subscription'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      email: map['email'] ?? '',
      userID: map['userID'] ?? '',
      userRole: map['userRole'] ?? '',
      verification: map['verification'] ?? '',
      fcmToken: map['fcm_token'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAccount.fromJson(String source) =>
      UserAccount.fromMap(json.decode(source));
}
