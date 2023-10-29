import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
    SignUp({
        this.profilePicture = "",
        this.firstName = "",
        this.lastName = "",
        this.street = "",
        this.city = "",
        this.state = "",
        this.zipCode = 0000,
        this.phoneNumber = "",
        this.email = "",
        this.password = "",
        this.userRole = "",
        this.diagnosticFee = 0,
        this.hourlyFee = 0,
        this.companyName = "",
        this.fcm_token = ""
    });

    String profilePicture;
    String firstName;
    String lastName;
    String street;
    String city;
    String state;
    int zipCode;
    String phoneNumber;
    String email;
    String password;
    String userRole;
    int diagnosticFee;
    int hourlyFee;
    String companyName;
    String fcm_token;
    factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        profilePicture: json["profilePicture"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        password: json["password"],
        userRole: json["userRole"],
        diagnosticFee: json["diagnosticFee"],
        hourlyFee: json["hourlyFee"],
        companyName: json["companyName"] ?? "",
        fcm_token: json["fcm_token"]??""
    );

    Map<String, dynamic> toJson() => {
        "profilePicture": profilePicture,
        "firstName": firstName,
        "lastName": lastName,
        "street": street,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "phoneNumber": phoneNumber,
        "email": email,
        "password": password,
        "userRole": userRole,
        "diagnosticFee": diagnosticFee,
        "hourlyFee": hourlyFee,
        "companyName": companyName,
        "fcm_token": fcm_token
    };
}
