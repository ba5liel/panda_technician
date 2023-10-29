import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
    Message({
        this.success = false,
        this.message = "",
        this.formIndex = 0,
    });

    bool success;
    String message;
    int formIndex;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"],
        message: json["message"],
      
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}
