class Description {
    Description({
        this.title = "",
        this.note = "",
        required this.attachments,
    });

    String title;
    String note;
    List<dynamic> attachments;

    factory Description.fromJson(Map<String, dynamic> json) => Description(
        title: json["title"],
        note: json["note"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "note": note,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
    };
}